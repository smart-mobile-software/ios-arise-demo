#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Repository.h"
#import "Deal.h"
#import "UIImage+iPhone5.h"

#import <Arise/AriseAB.h>

static NSString * const ImageStateNormal = @"";
static NSString * const ImageStateSelected = @"_selected";

@interface MasterViewController () {
    NSArray         *_objects;
    NSIndexPath     *currentSelectedDeal;
    BOOL             preselectedFirst;
    UIColor         *textColor;
}

@property NSInteger testIndex;

- (void)selectCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)deselectCellAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize testIndex;

- (void)selectTest{
    
    
    NSLog(@"attempting test");
    
    [AriseAB testWithName:@"detailViewLayout" A:^{
        testIndex = 0;
        NSLog(@"changing layout index to %d", testIndex);
    } B:^{
        testIndex = 1;
        NSLog(@"changing layout index to %d", testIndex);
    }
     ];

    
}

- (IBAction)doABTest:(id)sender{
    
    
    [self performSelector:@selector(selectTest) withObject:nil afterDelay:1];
       

}

- (void)awakeFromNib
{
      [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"background_deals.png"]];
    _objects = [Repository loadDemoData];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.detailViewController.detailItem = _objects[0];
    }
    
    testIndex = 0;
    
      
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !preselectedFirst) {
        preselectedFirst = YES;
        currentSelectedDeal = [NSIndexPath indexPathForRow:0 inSection:0];
        [self selectCellAtIndexPath:currentSelectedDeal];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    
    [self doABTest:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 1;
        } else {
            return 2;
        }
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return _objects.count;
        } else {
            switch (section) {
                case 0: {
                    return _objects.count > 0 ? 1 : 0;
                    break;
                }
                case 1: {
                    return _objects.count-1;
                    break;
                }
                default:
                    return 0;
                    break;
            }
        }
    } else {
        if (_objects.count) {
            Deal *object = _objects[0];
            return object.featuredDetails.count;
        }
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return [((Deal*)_objects[indexPath.row]).title 
                    sizeWithFont:[UIFont boldSystemFontOfSize:20.0f] constrainedToSize:tableView.bounds.size].height + 20;
        } else {
            switch (indexPath.section) {
                case 0: {
                    return 225;
                    break;
                }
                case 1: {
                    return 82;
                    break;
                }
                default:
                    return 82;
                    break;
            }
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 36;
        } else {
            return 20;
        }
    }
    
    
}

- (UIImageView *)backgroundForCellAtIndexPath:(NSIndexPath *)indexPath forState:(NSString *)state {
    UIImage *imgBkg;
    UIImageView *imgViewBkg;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        imgBkg = [UIImage imageNamed:[NSString stringWithFormat:@"dealCellBkg%@.png", state, nil]];
        imgViewBkg = [[UIImageView alloc] initWithImage:[imgBkg stretchableImageWithLeftCapWidth:5 topCapHeight:0]];
    } else {
        switch (indexPath.section) {
            case 0: {
                imgBkg = [UIImage imageNamed:[NSString stringWithFormat:@"deal-detail-box%@.png", state, nil]];
                imgViewBkg = [[UIImageView alloc] initWithImage:[imgBkg resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12)]];
                break;
            }
            case 1: {
                if(indexPath.row == 0 || _objects.count == 3 || indexPath.row == _objects.count-1) {
                    NSString *imgName = indexPath.row == 0 ? (_objects.count > 2 ? @"dealsCellBkgFirst%@.png" : @"deal-detail-box%@.png") : @"dealsCellBkgLast%@.png";
                    imgName = [NSString stringWithFormat:imgName, state, nil];
                    UIEdgeInsets edge = indexPath.row == 0 ? UIEdgeInsetsMake(12, 12, 12, 12) : UIEdgeInsetsMake(0, 12, 12, 12);
                    imgBkg = [UIImage imageNamed:imgName];
                    imgViewBkg = [[UIImageView alloc] initWithImage:[imgBkg resizableImageWithCapInsets:edge]];
                } else  {
                    imgBkg = [UIImage imageNamed:[NSString stringWithFormat:@"dealsCellBkgMiddle%@.png", state, nil]];
                    imgViewBkg = [[UIImageView alloc] initWithImage:[imgBkg stretchableImageWithLeftCapWidth:5 topCapHeight:0]];
                }
                break;
            }
        }
    }
    imgViewBkg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    return imgViewBkg;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (aTableView == self.tableView) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            Deal *object = _objects[indexPath.row];
            cell = [aTableView dequeueReusableCellWithIdentifier:@"Cell"];
            cell.textLabel.text = object.title;
            cell.textLabel.numberOfLines = 0;
            UIImage *imgBkg = [UIImage imageNamed:@"dealCellBkg.png"];
            UIImageView *imgViewBkg = [[UIImageView alloc] initWithImage:[imgBkg stretchableImageWithLeftCapWidth:5 topCapHeight:0]];
            imgViewBkg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            
            cell.backgroundView = imgViewBkg;
        } else {
            NSString *cellIdentifier = indexPath.section == 0 ? @"featuredCell" : @"dealsCell";
            cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
              
            NSInteger index = indexPath.section == 0 ? indexPath.row : indexPath.row+1;
            Deal *object = _objects[index];
            UILabel *lblTitle = (UILabel *)[cell viewWithTag:1];
            lblTitle.text = object.title;
            
            UIImageView *imgDeal = (UIImageView *)[cell viewWithTag:20];
           imgDeal.image = object.image;
            
            if(indexPath.section == 1) {
                UIImageView *imgDisclosure = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-item-arrow.png"]];
                cell.accessoryView = imgDisclosure;
                UILabel *lblPrice = (UILabel *)[cell viewWithTag:3];
                lblPrice.text = (object.details)[@"Price"];
                UILabel *lblSavings = (UILabel *)[cell viewWithTag:4];
                lblSavings.text = (object.details)[@"Savings"];
            }
        }
        
        cell.backgroundView = [self backgroundForCellAtIndexPath:indexPath forState:ImageStateNormal];
    } else {
        Deal *object = _objects[0];
        cell = [aTableView dequeueReusableCellWithIdentifier:@"CellDetail"];
        UILabel *lblText = (UILabel *)[cell viewWithTag:1];
        NSString *detailName = (object.featuredDetails)[indexPath.row];
        lblText.text = [detailName stringByAppendingString:@":"];
        UILabel *lblVal = (UILabel *)[cell viewWithTag:2];
        lblVal.text = (object.details)[detailName];
    }
    return cell;
}

- (void)selectCellAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    textColor = cell.textLabel.textColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.shadowColor = [UIColor grayColor];
    cell.textLabel.shadowOffset = CGSizeMake(0,-1);
    
    cell.backgroundView = [self backgroundForCellAtIndexPath:indexPath forState:ImageStateSelected];
}

- (void)deselectCellAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = textColor;
    cell.textLabel.shadowColor = [UIColor clearColor];
    cell.textLabel.shadowOffset = CGSizeMake(0,0);
    cell.backgroundView = [self backgroundForCellAtIndexPath:indexPath forState:ImageStateNormal];
}

- (void)selectCellAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    CGFloat duration = animated ? 0.2 : 0.0;
    [UIView animateWithDuration:duration
                     animations:^{
                         [self selectCellAtIndexPath:indexPath];
                     }];
}

- (void)deselectCellAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    CGFloat duration = animated ? 0.2 : 0.0;
    [UIView animateWithDuration:duration
                     animations:^{
                         [self deselectCellAtIndexPath:indexPath];
                     }];
}

- (void)performCustomSegueBasedOnTest{
    
    switch (testIndex) {
        case 1:
              [self performSegueWithIdentifier:@"trialPushA" sender:self.tableView];
            break;
        case 2:
              [self performSegueWithIdentifier:@"trialPushB" sender:self.tableView];
            break;
        default:
            [self performSegueWithIdentifier:@"trialPushBaseline" sender:self.tableView];
            break;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
           
    [self performCustomSegueBasedOnTest];
    
}

- (IBAction)moreInfoClick:(id)sender{
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self performCustomSegueBasedOnTest];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"purchaseDeal"]) // || [[segue identifier] isEqualToString:@"moreInfo"]
    {
        Deal *object = _objects[0];
        [[segue destinationViewController] setDetailItem:object];
    }
    else{
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSInteger index = indexPath.section == 0 ? indexPath.row : indexPath.row+1;
        Deal *object = _objects[index];
        [[segue destinationViewController] setDetailItem:object];
        
        currentSelectedDeal = indexPath;
        [self selectCellAtIndexPath:currentSelectedDeal];
        [self performSelector:@selector(deselectCellAtIndexPath:) withObject:currentSelectedDeal afterDelay:0.1];

    }
}

@end
