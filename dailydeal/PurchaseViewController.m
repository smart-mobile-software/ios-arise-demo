#import "PurchaseViewController.h"
#import "Deal.h"

@interface PurchaseViewController ()

@end

@implementation PurchaseViewController
@synthesize tableView;
@synthesize detailItem = _detailItem;

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }       
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *viewBkg = [[UIView alloc] initWithFrame:self.view.bounds];
    viewBkg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_detail~iphone.png"]]; 
    self.tableView.backgroundView = viewBkg;
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setDetailItem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            // strip the free space from outside the cell being a Grouped TableView and the margin for the label
            CGSize cellSize = CGSizeMake(aTableView.bounds.size.width - 40, aTableView.bounds.size.height);
            return [_detailItem.title 
                    sizeWithFont:[UIFont boldSystemFontOfSize:17.0f] constrainedToSize:cellSize].height + 20;
            break;
        }
        case 1:
            return 80;
            break;
            
        case 2:
            return 50;
            break;
        default:
            return 100;
            break;
    }
    
}

- (UIImageView *)backgroundForCellAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *imgBkg;
    UIImageView *imgViewBkg;
    
    switch (indexPath.row) {
        case 0: {
            imgBkg = [UIImage imageNamed:@"purchaseCellBkgFirst.png"];
            imgViewBkg = [[UIImageView alloc] initWithImage:[imgBkg resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 0, 12)]];
            break;
        }
        case 1: 
        case 2: {
            imgBkg = [UIImage imageNamed:@"purchaseCellBkgMiddle.png"];
            imgViewBkg = [[UIImageView alloc] initWithImage:[imgBkg stretchableImageWithLeftCapWidth:5 topCapHeight:0]];
            break;
        }
        case 3: {
            imgBkg = [UIImage imageNamed:@"purchaseCellBkgLast.png"];
            imgViewBkg = [[UIImageView alloc] initWithImage:[imgBkg resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 12, 12)]];
            break;
        }
    }    
    imgViewBkg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    return imgViewBkg;
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell;
    NSString *cellIdentifier;
    switch (indexPath.row) {
        case 0: {
            cellIdentifier = @"default";
            cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if(_detailItem) {
                cell.textLabel.text = _detailItem.title;
                cell.textLabel.numberOfLines = 0;
            }
            break;
        }
        case 1: {
            cellIdentifier = @"cellValue";
            cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier]; 
            break;
        }
        case 2: {
            cellIdentifier = @"default";
            cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
            cell.textLabel.text = @"Choose payment method:";
            break;
        }
        case 3: {
            cellIdentifier = @"cellMethods";
            cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
            break;
        }
        default:
            cell = [aTableView dequeueReusableCellWithIdentifier:@"default"];
            break;
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [self backgroundForCellAtIndexPath:indexPath];
    return cell;
}


@end

