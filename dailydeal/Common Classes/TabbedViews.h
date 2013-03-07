#import <UIKit/UIKit.h>
#import "CustomSegmentedControl.h"

@interface TabbedViews : UIView <CustomSegmentedControlDelegate>

@property (nonatomic, strong)   NSArray     *titles;
@property (nonatomic, strong)   NSArray     *views;

@end
