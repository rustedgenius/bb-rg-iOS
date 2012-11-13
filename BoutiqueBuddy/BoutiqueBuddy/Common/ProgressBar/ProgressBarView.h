

#import <UIKit/UIKit.h>

@interface ProgressBarView : UIView
{

}
+ (id)loadingViewInView:(UIView *)aSuperview displySize:(CGRect)rect displyText:(NSString*)text;
- (void)removeView;

@end
