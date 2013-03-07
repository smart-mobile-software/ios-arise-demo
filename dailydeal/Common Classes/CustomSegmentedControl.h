@class CustomSegmentedControl;
@protocol CustomSegmentedControlDelegate

- (UIButton*) buttonFor:(CustomSegmentedControl*)segmentedControl atIndex:(NSUInteger)segmentIndex;

@optional
- (void) touchUpInsideSegmentIndex:(NSUInteger)segmentIndex;
- (void) touchDownAtSegmentIndex:(NSUInteger)segmentIndex;
@end

@interface CustomSegmentedControl : UIView
{
  NSObject <CustomSegmentedControlDelegate> *delegate;
  NSMutableArray* buttons;
}


- (id) initWithSegmentCount:(NSUInteger)segmentCount
               dividerImage:(UIImage*)dividerImage 
                        tag:(NSInteger)objectTag 
                   delegate:(NSObject <CustomSegmentedControlDelegate>*)customSegmentedControlDelegate;

@end
