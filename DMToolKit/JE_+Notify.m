
#import "JE_+Notify.h"

@implementation JE_ (Notify)
+ (NSNotificationCenter*)notifyCenter
{
    return [NSNotificationCenter defaultCenter];
}

+ (void)notifyName:(NSString*)name 
            object:(id) object
{
    [[JE_ notifyCenter] postNotificationName:name 
                                      object:object];
}

+ (void)notifyObserver:(id)observer 
              selector:(SEL)selector 
                  name:(NSString*)name
{
    [[JE_ notifyCenter] addObserver:observer 
                           selector:selector 
                               name:name 
                             object:nil];
}  
@end
