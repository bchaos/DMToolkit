
#import "JE_.h"
#import "JE_+Viewy.h"

@interface JE_ (NavigationBary)
+ (void)withNavigationBar:(UINavigationBar*)bar
  setBackgroundImageNamed:(NSString*)name;

+ (UIImageView*)withNavigationBar:(UINavigationBar*)bar
               addTitleImageNamed:(NSString*)imageName;
@end
