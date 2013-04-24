

#import "JE_+Array.h"

@implementation JE_ (Array)
+ (NSArray*)filterArray:(NSArray*)array
      usingSearchString:(NSString*)searchString
             onProperty:(NSString*)propertyName
{
    NSPredicate *predBlock = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        id evaluatedObjectPropertyObject = [evaluatedObject valueForKey:propertyName];
        if ([evaluatedObjectPropertyObject isKindOfClass:[NSString class]]) {
            NSString* string = evaluatedObjectPropertyObject;
            BOOL containsString = [JE_ string:string containsString:searchString];
            return containsString;
        }
        return NO;
    }];
    NSArray* filteredArray = [array filteredArrayUsingPredicate:predBlock];
    return filteredArray;
}

+ (NSArray*)filterArray:(NSArray*)array
     usingSearchStrings:(NSArray*)searchStrings
           onProperties:(NSArray*)propertyNames
{
    NSPredicate *predBlock = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        for (int i = 0 ; i < [propertyNames count] ; i++) {
            NSString* propertyName = [propertyNames objectAtIndex:i];
            NSString* searchString = [searchStrings objectAtIndex:i];
            
            if (![JE_ object:evaluatedObject
                propertyName:propertyName
              containsString:searchString]) {
                return NO;
            }
        }
        return YES;
    }];
    NSArray* filteredArray = [array filteredArrayUsingPredicate:predBlock];
    return filteredArray;
}

#pragma mark - Private
+ (BOOL)object:(id)object propertyName:(NSString*)propertyName containsString:(NSString*)searchString
{
    id evaluatedObjectPropertyObject = [object valueForKey:propertyName];
    if ([evaluatedObjectPropertyObject isKindOfClass:[NSString class]]) {
        NSString* string = evaluatedObjectPropertyObject;
        BOOL containsString = [JE_ string:string containsString:searchString];
        NSLog(@"\n\nSEARCH: %@\npropS: %@\n\n", searchString, string);
        return containsString;
    }
    return NO;
}

@end
