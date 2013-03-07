#import "TabbedDetailsView.h"
#import "TabbedViews.h"
#import "AdjustableCell.h"
#import "Deal.h"

@interface TabbedDetailsView () {
    UITableView *wygTable;
    UITableView *fdTable;
}

@property (nonatomic, strong) UITableView *wygTable;
@property (nonatomic, strong) UITableView *fdTable;
@property (strong, nonatomic) TabbedViews *tabbedViews;

- (UIView *)WYGView;
- (UIView *)FDView;

@end

@implementation TabbedDetailsView

@synthesize wygTable;
@synthesize fdTable;
@synthesize tabbedViews;
@synthesize detailItem = _detailItem;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tabbedViews = [[TabbedViews alloc] initWithFrame:self.bounds];
        self.tabbedViews.titles = @[@"What you get", @"Finer details"];
        
        self.tabbedViews.views = @[[self WYGView], 
                                  [self FDView]];
        self.tabbedViews.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.tabbedViews];
    }
    return self;
}

- (void)setDetailItem:(Deal *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [wygTable reloadData];
    }        
}

- (UIView *)WYGView {
    UIView *wygView = [[UIView alloc] initWithFrame:CGRectZero];
    wygView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    wygTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    wygTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    wygTable.delegate = self;
    wygTable.dataSource = self;
    wygTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [wygView addSubview:wygTable];
    return wygView;
}

- (UIView *)FDView {
    UIView *fdView = [[UIView alloc] initWithFrame:CGRectZero];
    fdView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    fdTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    fdTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    fdTable.delegate = self;
    fdTable.dataSource = self;
    
    [fdView addSubview:fdTable];
    return fdView;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == wygTable) {
        return _detailItem.contents.count;
    } else {
        return _detailItem.details.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == wygTable) {
        // strip the margin for the label and the imageview
        CGSize cellSize = CGSizeMake(tableView.bounds.size.width - 40, tableView.bounds.size.height);
        return [(_detailItem.contents)[indexPath.row] 
                sizeWithFont:APP_GLOBAL_FONT constrainedToSize:cellSize].height + 10;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CellWYG";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[AdjustableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"check.png"];
    cell.textLabel.text = (_detailItem.contents)[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = APP_GLOBAL_FONT;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
