

#import "JE_.h"
#import "JE_+Filey.h"
#import "JE_+Downloady.h"

@interface JE_ (JSONy)

+ (NSMutableDictionary*)stringToDictionary:(NSString*)string;


+ (BOOL)saveDictionary:(NSMutableDictionary*)dictionary
                  path:(NSString*)path;

+ (BOOL)saveDictionary:(NSMutableDictionary*)dictionary
                  path:(NSString*)path
             overwrite:(BOOL)overwrite;

+ (NSString*)dictionaryToQueryString:(NSDictionary*)dict;
+(id)objectForkeyWithValidation :(NSDictionary *)dictionary keyToValidate:(NSString *)key orDefaultValue:(id)defaultValue;
@end
