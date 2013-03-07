#import <UIKit/UIKit.h>

@class Deal;

@interface TabbedDetailsView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Deal *detailItem;

@end
