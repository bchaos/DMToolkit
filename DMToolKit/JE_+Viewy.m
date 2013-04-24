

#import "JE_+Viewy.h"

@implementation JE_ (Viewy)

+ (UIView*)nibNamed:(NSString*)name
{
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] objectAtIndex:0];
}

+ (UIView*)viewWithWidth:(float)width height:(float)height
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
}

+ (UIView*)viewWithView:(UIView*)view
{
    return [[UIView alloc] initWithFrame:view.bounds];
}

#pragma mark - Move view origin methods

+ (void)moveView:(UIView*)view toX:(float)x y:(float)y
{
    [JE_ moveView:view toPoint:CGPointMake(x, y)];
}

+ (void)moveView:(UIView *)view toX:(float)x
{
    [JE_ moveView:view toPoint:CGPointMake(x, view.frame.origin.y)];
}

+ (void)moveView:(UIView *)view toY:(float)y
{
    [JE_ moveView:view toPoint:CGPointMake(view.frame.origin.x, y)];
}

+ (void)moveView:(UIView*)view toPoint:(CGPoint)point
{
    CGRect frame = view.frame;
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    view.frame = frame;
}

+ (void)offsetView:(UIView*)view
         byXAmount:(float)x
         byYAmount:(float)y
{
    view.frame = [JE_ offsetFrame:view.frame
                        withPoint:CGPointMake(x, y)];
}

#pragma mark Move view center methods

+ (void)moveView:(UIView *)view centerToX:(float)x y:(float)y
{
    view.center = CGPointMake(x, y);
}

+ (void)setView:(UIView*)view
          width:(float)width
         height:(float)height
{
    CGRect frame = view.frame;
    frame.size.width = width;
    frame.size.height = height;
    view.frame = frame;
}

+ (void)adjustView:(UIView*)view
             width:(float)width
{
    CGRect frame = view.frame;
    frame.size.width = width;
    view.frame = frame;
}

+ (void)adjustView:(UIView*)view
            height:(float)height
{
    CGRect frame = view.frame;
    frame.size.height = height;
    view.frame = frame;
}

+ (void)increaseView:(UIView*)view
       byWidthAmount:(float)width
      byHeightAmount:(float)height
{
    CGRect frame = view.frame;
    frame.size.width += width;
    frame.size.height += height;
    view.frame = frame;
}

+ (CGPoint)withPoint:(CGPoint)point addToY:(float)amount
{
    return CGPointMake(point.x, point.y + amount);
}

+ (CGPoint)withPoint:(CGPoint)point addToX:(float)amount
{
    return CGPointMake(point.x + amount, point.y);
}

+ (CGRect)offsetFrame:(CGRect)frame withPoint:(CGPoint)point
{
    return CGRectMake(frame.origin.x + point.x, frame.origin.y + point.y, frame.size.width, frame.size.height);
}

+ (CGRect)offsetFrame:(CGRect)frame xByAmount:(float)amount
{
    return [JE_ offsetFrame:frame withPoint:CGPointMake(frame.origin.x + amount, frame.origin.y)];
}
+ (CGRect)offsetFrame:(CGRect)frame yByAmount:(float)amount
{
    return [JE_ offsetFrame:frame withPoint:CGPointMake(frame.origin.x, frame.origin.y + amount)];;
}

+ (void)applyGradientToView:(UIView*)view withImageNamed:(NSString*)name
{
    UIImage* image = [UIImage imageNamed:name];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, view.frame.size.height), NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, 1, view.frame.size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    view.backgroundColor = [UIColor colorWithPatternImage:newImage];
}

+ (void)withView:(UIView*)view setBackgroundWithRed:(int)red green:(int)green blue:(int)blue alpha:(float)alpha
{
    view.backgroundColor = [JE_ colorWithRed:red
                                       green:green
                                        blue:blue
                                       alpha:alpha];
}

+ (UIColor*)colorWithRed:(int)red green:(int)green blue:(int)blue alpha:(float)alpha
{
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImageView*) imageViewWithView:(UIView*)view
{
    UIImage* image = [JE_ imageWithView:view];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    return imageView;
}

+ (UIView*)rootView
{
    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

+ (void)borderView:(UIView*)view
             color:(UIColor*)color
             width:(float)width
            radius:(float)radius
{
    view.layer.cornerRadius = radius;
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = width;
}
@end
