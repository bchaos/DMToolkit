

#import "JE_+JSONy.h"

@implementation JE_ (JSONy)
+ (NSMutableDictionary*)stringToDictionary:(NSString*)jsonString
{
    NSError* error = nil;
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&error];
    
    if([dictionary isKindOfClass:[NSArray class]])
     dictionary=  [NSMutableArray arrayWithArray:[self stripNullValuesArray:dictionary]];
    else if([dictionary isKindOfClass:[NSDictionary class]])
    dictionary= [NSMutableDictionary dictionaryWithDictionary:[self stripNullValues:dictionary]];
    
    __block id (^removeNull)(id) = ^(id dictionary) {
        // Recurse through dictionaries
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *sanitizedDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
            [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                id sanitized = removeNull(obj);
                if (!sanitized) {
                    [sanitizedDictionary removeObjectForKey:key];
                } else {
                    [sanitizedDictionary setObject:sanitized forKey:key];
                }
            }];
            
            return [NSDictionary dictionaryWithDictionary:sanitizedDictionary];
        }
        
        // Recurse through arrays
        if ([dictionary isKindOfClass:[NSArray class]]) {
            NSMutableArray *sanitizedArray = [NSMutableArray arrayWithArray:dictionary];
            [dictionary enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                id sanitized = removeNull(obj);
                if (!sanitized) {
                    [sanitizedArray removeObjectIdenticalTo:obj];
                } else {
                    [sanitizedArray replaceObjectAtIndex:[sanitizedArray indexOfObject:obj] withObject:sanitized];
                }
            }];
            
            return [NSArray arrayWithArray:sanitizedArray];
        }
        
        // Base case
        if ([dictionary isKindOfClass:[NSNull class]]) {
            return (id)nil;
        } else {
            return dictionary;
        }
    };
    return dictionary;
}

+ (NSArray *)stripNullValuesArray:(NSArray *)array
{
    NSMutableArray * newArray=[[NSMutableArray alloc]initWithArray:array];
    for (int i = [newArray count] - 1; i >= 0; i--)
    {
        id value = [newArray objectAtIndex:i];
        if (value == [NSNull null])
        {
            [newArray removeObjectAtIndex:i];
        }
        else if ([value isKindOfClass:[NSArray class]] ||
                 [value isKindOfClass:[NSDictionary class]])
        {
            if (![value respondsToSelector:@selector(setObject:forKey:)] &&
                ![value respondsToSelector:@selector(addObject:)])
            {
                value = [value mutableCopy];
                [newArray replaceObjectAtIndex:i withObject:value];
            }
            if([value isKindOfClass:[NSArray class]] )
                [newArray replaceObjectAtIndex:i withObject:[self stripNullValuesArray:value]];
            
            else
                [newArray replaceObjectAtIndex:i withObject:[self stripNullValues:value]];
            
        }
    }
    return newArray;
}

+ (NSDictionary *)stripNullValues:(NSDictionary *)dic
{
    NSMutableDictionary * newDic= [[NSMutableDictionary alloc]initWithDictionary:dic];
    for (NSString *key in [newDic allKeys])
    {
        id value = [newDic objectForKey:key];
        if (value == [NSNull null])
        {
            [newDic removeObjectForKey:key];
        }
        else if ([value isKindOfClass:[NSArray class]] ||
                 [value isKindOfClass:[NSDictionary class]])
        {
            if (![value respondsToSelector:@selector(setObject:forKey:)] &&
                ![value respondsToSelector:@selector(addObject:)])
            {
                value = [value mutableCopy];
                [newDic setObject:value forKey:key];
            }
            if([value isKindOfClass:[NSArray class]] )
                [newDic setObject:[self stripNullValuesArray:value] forKey:key] ;
            else
                [newDic setObject:  [self stripNullValues:value] forKey:key] ;
            
        }
    }
    return newDic;
}

+ (BOOL)saveDictionary:(NSMutableDictionary*)dictionary
                  path:(NSString*)path
{
    if (![NSJSONSerialization isValidJSONObject:dictionary]) {
        NSLog(@"Invalid JSON in %s", __FUNCTION__);
        return NO;
    }
    
    NSString* folderPath = [path stringByDeletingLastPathComponent];
    if (![JE_ fileExists:folderPath]) {
        if ([JE_ createFolder:folderPath]) {
            NSLog(@"There was an error when we tried to create the folder path.");
            return NO;
        }
    }
    
    NSOutputStream* stream = [NSOutputStream outputStreamToFileAtPath:path
                                                               append:NO];
    [stream open];
    NSError* error = nil;
    [NSJSONSerialization writeJSONObject:dictionary
                                toStream:stream
                                 options:NSJSONWritingPrettyPrinted
                                   error:&error];
    [stream close];
    if (error) {
        NSLog(@"Saving JSON failed: %@", [error localizedDescription]);
        return NO;
    }
    return YES;

}

+ (BOOL)saveDictionary:(NSMutableDictionary*)dictionary
                  path:(NSString*)path
             overwrite:(BOOL)overwrite
{
    if (!overwrite) {
        [JE_ fileExists:path];
        NSLog(@"File exists at path: %@, set the overwrite parameter to YES if you would like to overwrite.", path);
        return NO;
    }
    return [JE_ saveDictionary:dictionary
                          path:path];
}
//this needs to be fixed... makeUrlSafe shouldn't be called.
+ (NSString*)dictionaryToQueryString:(NSDictionary*)dict
{
    NSArray* arr = [JE_ queryStringComponentsFromKey:nil value:dict];
    return [arr componentsJoinedByString:@"&"];//[JE_ makeUrlSafe:[arr componentsJoinedByString:@"&"]];
}

+ (NSArray*)queryStringComponentsFromKey:(NSString *)key value:(id)value {
    NSMutableArray *queryStringComponents = [NSMutableArray arrayWithCapacity:2];
    if ([value isKindOfClass:[NSDictionary class]]) {
        [queryStringComponents addObjectsFromArray:[self queryStringComponentsFromKey:key dictionaryValue:value]];
    } else if ([value isKindOfClass:[NSArray class]]) {
        [queryStringComponents addObjectsFromArray:[self queryStringComponentsFromKey:key arrayValue:value]];
    } else {
        static NSString * const kLegalURLEscapedCharacters = @"?!@#$^&%*+=,:;'\"`<>()[]{}/\\|~ ";
        NSString *valueString = [value description];
        NSString *unescapedString = [valueString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if (unescapedString) {
            valueString = unescapedString;
        }
        NSString *escapedValue = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge_retained CFStringRef)valueString, NULL, (__bridge_retained CFStringRef) kLegalURLEscapedCharacters, CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
        
        NSString *component = [NSString stringWithFormat:@"%@=%@", key, escapedValue];
        [queryStringComponents addObject:component];
    }
    
    return queryStringComponents;
}

+ (NSArray*)queryStringComponentsFromKey:(NSString *)key dictionaryValue:(NSDictionary *)dict{
    NSMutableArray *queryStringComponents = [NSMutableArray arrayWithCapacity:2];
    [dict enumerateKeysAndObjectsUsingBlock:^(id nestedKey, id nestedValue, BOOL *stop) {
        NSArray *components = nil;
        if (key == nil) {
            components = [self queryStringComponentsFromKey:nestedKey value:nestedValue];
        } else {
            components = [self queryStringComponentsFromKey:[NSString stringWithFormat:@"%@[%@]", key, nestedKey] value:nestedValue];
        }
        
        [queryStringComponents addObjectsFromArray:components];
    }];
    
    return queryStringComponents;
}

+ (NSArray* )queryStringComponentsFromKey:(NSString *)key arrayValue:(NSArray *)array{
    NSMutableArray *queryStringComponents = [NSMutableArray arrayWithCapacity:2];
    [array enumerateObjectsUsingBlock:^(id nestedValue, NSUInteger index, BOOL *stop) {
        [queryStringComponents addObjectsFromArray:[self queryStringComponentsFromKey:[NSString stringWithFormat:@"%@[]", key] value:nestedValue]];
    }];
    
    return queryStringComponents;
}



+(id)objectForkeyWithValidation :(NSDictionary *)dictionary keyToValidate:(NSString *)key orDefaultValue:(id)defaultValue{
    
    if([dictionary objectForKey:key])return [dictionary objectForKey:key];
    return defaultValue;
}

@end
