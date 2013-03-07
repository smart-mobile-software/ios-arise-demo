#import "TabbedViews.h"

#define BUTTON_WIDTH 155.0
#define BUTTON_SEGMENT_WIDTH 155.0
#define CAP_WIDTH 12.0

typedef enum {
    CapLeft          = 0,
    CapMiddle        = 1,
    CapRight         = 2,
    CapLeftAndRight  = 3
} CapLocation;

@interface TabbedViews () {
    NSInteger currentViewIndex;
}

@property (nonatomic, strong)   CustomSegmentedControl  *tabs;

- (void)setSelectedView:(NSInteger)index;
- (UIButton*)tabButtonWithText:(NSString*)buttonText stretch:(CapLocation)location;

@end


@implementation TabbedViews

@synthesize tabs;
@synthesize views;
@synthesize titles;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    if (!self.tabs) {
        UIImage* dividerImage = [UIImage imageNamed:@"tab_divider.png"];
        
        CGFloat dividerImageH = dividerImage.size.height;
        self.tabs = [[CustomSegmentedControl alloc] initWithSegmentCount:titles.count 
                                                            dividerImage:dividerImage tag:0 delegate:self];
        self.tabs.frame = CGRectMake(0, 0, viewWidth, dividerImageH);
        [self addSubview:self.tabs];
        
        CGFloat viewBkgH = viewHeight - dividerImageH;
        UIView *viewBkg = [[UIView alloc] initWithFrame:CGRectMake(0, dividerImageH, viewWidth, viewBkgH)];
        viewBkg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        UIImage *imgBkg = [UIImage imageNamed:@"tab_view_bkg.png"];
        UIImageView *imgViewBkg = [[UIImageView alloc] 
                                   initWithImage:[imgBkg resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 12, 12)]]; 
        imgViewBkg.frame = viewBkg.bounds;
        imgViewBkg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [viewBkg addSubview:imgViewBkg];
        [self addSubview:viewBkg];
        
        CGFloat viewMargin = 10;
        CGRect frameView = CGRectMake(viewMargin, 
                                      dividerImageH + viewMargin, 
                                      viewWidth-2*viewMargin, 
                                      viewBkg.bounds.size.height -2*viewMargin);
        for(UIView *view in self.views) {
            view.frame = frameView;
            view.alpha = 0;
            [self addSubview:view];
        }
        if (self.views.count > 0) {
            currentViewIndex = 0;
            [self setSelectedView:currentViewIndex];
        }
    }

}

- (void)setSelectedView:(NSInteger)index {
    UIView *view = (self.views)[currentViewIndex];
    view.alpha = 0;
    currentViewIndex = index;
    view = (self.views)[index];
    view.alpha = 1;
}


#pragma mark -
#pragma mark CustomSegmentedControlDelegate

- (UIButton*)buttonFor:(CustomSegmentedControl*)segmentedControl atIndex:(NSUInteger)segmentIndex;
{    
    UIButton* button = [self tabButtonWithText:titles[segmentIndex] stretch:CapLeftAndRight];
    if (segmentIndex == 0)
        button.selected = YES;
    return button;
}

- (void)touchDownAtSegmentIndex:(NSUInteger)segmentIndex {
    [self setSelectedView:segmentIndex];
}

- (UIButton*)tabButtonWithText:(NSString*)buttonText stretch:(CapLocation)location
{
    UIImage* buttonImage = nil;
    UIImage* buttonPressedImage = nil;
    NSUInteger buttonWidth = 0;
    if (location == CapLeftAndRight)
    {
        buttonWidth = BUTTON_WIDTH;
        buttonImage = [[UIImage imageNamed:@"tab_deselected.png"] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0];
        buttonPressedImage = [[UIImage imageNamed:@"tab_selected.png"] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0];
    }    
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, buttonWidth, buttonImage.size.height);
    button.titleLabel.font = [UIFont boldSystemFontOfSize: APP_GLOBAL_FONT_SIZE];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateSelected];
    button.titleLabel.shadowOffset = CGSizeMake(0,-1);
    
    [button setTitle:buttonText forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = NO;
    
    return button;
}

@end
