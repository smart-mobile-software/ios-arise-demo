#import "DetailViewController.h"
#import "TabbedDetailsView.h"
#import "DetailCell.h"
#import "Deal.h"

#import <Arise/AriseAB.h>

@interface DetailViewController () {
    BOOL resizedStartup;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) TabbedDetailsView *tabbedViews;
@property (weak, nonatomic) UIPopoverController *purchasePopover;

- (void)configureView;
- (CGRect)frameForTabs;
@end

@implementation DetailViewController

@synthesize tabbedViews;
@synthesize detailItem = _detailItem;
@synthesize viewDetails = _viewDetails;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize detailDealImage = _detailDealImage;
@synthesize tableView = _tableView;
@synthesize imgViewDetails = _imgViewDetails;
@synthesize imgViewFrame = _imgViewFrame;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize purchasePopover;

#pragma mark - Managing the detail item

- (void)setDetailItem:(Deal *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)setBackgroundForOrientation:(UIInterfaceOrientation)orientation {
    NSString *imageName;
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        imageName = @"background_detail.png";
    } else {
        imageName = @"background_detail_Landscape.png";
    }
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
}

- (void)layoutViews {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.tableView reloadData];
        [self.tabbedViews setDetailItem:_detailItem];
    }
    
    CGRect viewFrame = self.viewDetails.frame;
    CGSize labelSize = viewFrame.size;
    labelSize.width -= 20;
    
    CGFloat verticalMargin;
    CGFloat fontSize;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        verticalMargin = 20;
        fontSize = 26;
    } else {
        verticalMargin = 10;
        fontSize = 17;
    }
    
    CGFloat originalH = self.detailDescriptionLabel.bounds.size.height;
    CGRect titleFrame = self.detailDescriptionLabel.frame;
    titleFrame.size.height = [_detailItem.title 
                              sizeWithFont:[UIFont boldSystemFontOfSize:fontSize] constrainedToSize:labelSize].height;
    
    CGRect imgFrameRect = self.imgViewFrame.frame;  
    CGRect detailImageFrame = self.detailDealImage.frame;
    CGFloat imgMargin = detailImageFrame.origin.y - imgFrameRect.origin.y;
    
    titleFrame.origin.y = verticalMargin;
    self.detailDescriptionLabel.frame = titleFrame;
    
    imgFrameRect.origin.y = titleFrame.origin.y + titleFrame.size.height + verticalMargin;
    self.imgViewFrame.frame = imgFrameRect;
    
    detailImageFrame.origin.y = imgFrameRect.origin.y + imgMargin;
    self.detailDealImage.frame = detailImageFrame;
    
    CGRect tableFrame = self.tableView.frame;
    tableFrame.origin.y = imgFrameRect.origin.y;
    self.tableView.frame = tableFrame;
    
    CGRect imgViewFrame = self.imgViewDetails.frame;
    imgViewFrame.size.height = viewFrame.size.height + (titleFrame.size.height - originalH);
    viewFrame.size.height = imgViewFrame.size.height;
    self.imgViewDetails.frame = imgViewFrame;
    self.viewDetails.frame = viewFrame;
    
    self.tabbedViews.frame = [self frameForTabs];
}

- (void)configureView {
    if (self.detailItem) {
        self.detailDescriptionLabel.text = _detailItem.title;
        self.detailDealImage.image = _detailItem.image;
        if(self.viewDetails.frame.size.height == 0)
            return;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && resizedStartup) {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 [self layoutViews];
                             }];
        } else {
            resizedStartup = YES;
            [self layoutViews];
        }
    }
    self.view.backgroundColor = [UIColor clearColor];
}

- (CGRect)frameForTabs {
    CGRect viewFrame = self.viewDetails.frame;
    CGFloat tabbedViewsMargin;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        tabbedViewsMargin = 20;
    } else {
        tabbedViewsMargin = 10;    
    }
    
    
    CGFloat tabbedViewsY = viewFrame.origin.y + viewFrame.size.height + tabbedViewsMargin;
    CGFloat tabbedViewsHeight = self.view.bounds.size.height - tabbedViewsY - tabbedViewsMargin;
    
    if(viewFrame.origin.y > 100){
        
        tabbedViewsY = 0 + tabbedViewsMargin;
        tabbedViewsHeight = self.view.bounds.size.height - (self.view.bounds.size.height - viewFrame.origin.y) - tabbedViewsMargin;
    }
   
    return CGRectMake(viewFrame.origin.x,
                      tabbedViewsY,     
                      viewFrame.size.width,
                      tabbedViewsHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];      
    
    
    self.tabbedViews = [[TabbedDetailsView alloc] 
                        initWithFrame:[self frameForTabs]];
    self.tabbedViews.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tabbedViews.detailItem = _detailItem;
    [self.view addSubview:self.tabbedViews];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setImgViewDetails:nil];
    [self setDetailDealImage:nil];
    [self setImgViewFrame:nil];
    [self setViewDetails:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.detailDescriptionLabel = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setBackgroundForOrientation:self.interfaceOrientation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self setBackgroundForOrientation:toInterfaceOrientation];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Deals", @"Deals");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _detailItem.featuredDetails.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 36;
    } else {
        return 20;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CellDetail";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *detailName = (_detailItem.featuredDetails)[indexPath.row];
    UILabel *lblText = (UILabel *)[cell viewWithTag:1];
    lblText.text = [detailName stringByAppendingString:@":"];
    UILabel *lblVal = (UILabel *)[cell viewWithTag:2];
    lblVal.text = (_detailItem.details)[detailName];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setDetailItem:_detailItem];
    
    
    [AriseAB goalReached:@"detailViewLayout"];
    
}

@end
