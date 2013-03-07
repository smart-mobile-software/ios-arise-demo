#import <UIKit/UIKit.h>

@class Deal;

@interface PurchaseViewController : UIViewController

@property (strong, nonatomic) Deal *detailItem;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
