
#import "JE_+Stringy.h"

@implementation JE_ (Stringy)
+ (NSString*)trimAllWhitey:(NSString*)string
{
    if ([string isEqual:[NSNull null]]) {
        return @"";
    }
    return [string stringByTrimmingCharactersInSet:
                   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)string:(NSString*)string
containsString:(NSString*)substring
{
    
   if(![string isKindOfClass:[NSString class]])
       return NO;
    string = [string lowercaseString];
    substring = [substring lowercaseString];
    
    NSRange textRange = [string rangeOfString:substring];
    if (textRange.location != NSNotFound) {
        return YES;
    }
    return NO;
}

+ (NSString*)prettyMoneyFloat:(float)num
{
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString* prettyMoneyFloat = [formatter stringFromNumber:[NSNumber numberWithFloat:num]];
    return prettyMoneyFloat;
}

+ (NSString *)GetUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)(string);
}
@end
