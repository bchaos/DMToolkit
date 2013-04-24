

#import "JE_.h"

@interface JE_ (Notify)
+ (NSNotificationCenter*)notifyCenter;

+ (void)notifyName:(NSString*)name 
            object:(id) object;

+ (void)notifyObserver:(id)observer 
              selector:(SEL)selector 
                  name:(NSString*)name;
@end
