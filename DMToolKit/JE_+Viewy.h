

#import "JE_.h"
#import <QuartzCore/QuartzCore.h>

@interface JE_ (Viewy)

+ (UIView*)nibNamed:(NSString*)name;
+ (UIView*)viewWithWidth:(float)width height:(float)height;
+ (UIView*)viewWithView:(UIView*)view;

+ (void)moveView:(UIView*)view
         toPoint:(CGPoint)point;
+ (void)moveView:(UIView*)view
             toX:(float)x
               y:(float)y;
+ (void)moveView:(UIView *)view
             toX:(float)x;
+ (void)moveView:(UIView *)view
             toY:(float)y;

+ (void)offsetView:(UIView*)view
         byXAmount:(float)x
         byYAmount:(float)y;

+ (void)moveView:(UIView *)view
       centerToX:(float)x
               y:(float)y;

+ (void)setView:(UIView*)view
          width:(float)width
         height:(float)height;

+ (void)adjustView:(UIView*)view
             width:(float)width;

+ (void)adjustView:(UIView*)view
            height:(float)height;

+ (void)increaseView:(UIView*)view
       byWidthAmount:(float)width
      byHeightAmount:(float)height;

+ (CGPoint)withPoint:(CGPoint)point addToY:(float)amount;
+ (CGPoint)withPoint:(CGPoint)point addToX:(float)amount;

+ (CGRect)offsetFrame:(CGRect)frame withPoint:(CGPoint)point;
+ (CGRect)offsetFrame:(CGRect)frame xByAmount:(float)amount;
+ (CGRect)offsetFrame:(CGRect)frame yByAmount:(float)amount;

+ (void)applyGradientToView:(UIView*)view withImageNamed:(NSString*)name;

+ (void)withView:(UIView*)view setBackgroundWithRed:(int)red green:(int)green blue:(int)blue alpha:(float)alpha;
+ (UIColor*)colorWithRed:(int)red green:(int)green blue:(int)blue alpha:(float)alpha;

+ (UIImage *) imageWithView:(UIView *)view;
+ (UIImageView*) imageViewWithView:(UIView*)view;

+ (UIView*)rootView;

+ (void)borderView:(UIView*)view
             color:(UIColor*)color
             width:(float)width
            radius:(float)radius;
@end
