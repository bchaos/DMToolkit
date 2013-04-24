

#import "JE_.h"

@interface JE_ (Alerty)

+ (void)okWithTitle:(NSString*)title
            message:(NSString*)message;

+ (void)authenticationWithTitle:(NSString*)title delegate:(id)delegate;
@end
