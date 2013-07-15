
#import "JE_.h"

@interface JE_ (Stringy)
+ (NSString*)trimAllWhitey:(NSString*)string;
+ (BOOL)string:(NSString*)string
containsString:(NSString*)substring;

+ (NSString*)prettyMoneyFloat:(float)num;
+ (NSString *)GetUUID;
@end
