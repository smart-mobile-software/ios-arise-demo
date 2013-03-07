#import "CustomSegmentedControl.h"

@interface CustomSegmentedControl()

@property (nonatomic, strong) NSMutableArray* buttons;
@property (nonatomic, strong) NSMutableArray* dividers;
@property (nonatomic, strong) UIImage* dividerImg;

@end

@implementation CustomSegmentedControl

@synthesize buttons;
@synthesize dividers;
@synthesize dividerImg;

- (id) initWithSegmentCount:(NSUInteger)segmentCount 
               dividerImage:(UIImage*)dividerImage 
                        tag:(NSInteger)objectTag 
                   delegate:(NSObject <CustomSegmentedControlDelegate>*)customSegmentedControlDelegate
{
    if (self = [super init])
    {
        // The tag allows callers withe multiple controls to distinguish between them
        self.tag = objectTag;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        // Set the delegate
        delegate = customSegmentedControlDelegate;
        
        // Initalize the array we use to store our buttons
        self.buttons = [[NSMutableArray alloc] initWithCapacity:segmentCount];
        self.dividers = [[NSMutableArray alloc] initWithCapacity:segmentCount-1];
        
        self.dividerImg = dividerImage;
        
        // Iterate through each segment
        for (NSUInteger i = 0 ; i < segmentCount ; i++)
        {
            // Ask the delegate to create a button
            UIButton* button = [delegate buttonFor:self atIndex:i];
            
            // Register for touch events
            [button addTarget:self action:@selector(touchDownAction:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchUpOutside];
            [button addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchDragOutside];
            [button addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchDragInside];
            
            // Add the button to our buttons array
            [buttons addObject:button];
            
            // Add the button as our subview
            [self addSubview:button];
            
            // Add the divider unless we are at the last segment
            if (i != segmentCount - 1)
            {
                UIImageView* divider = [[UIImageView alloc] initWithImage:dividerImage];
                [self addSubview:divider];
                [dividers addObject:divider];
            }
        }
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat horizontalOffset = 0;
    CGFloat buttonWidth = floor((self.bounds.size.width - 0)  / buttons.count);
    
    for (NSUInteger i = 0 ; i < buttons.count ; i++)
    {        
        UIButton *button = buttons[i];
        button.frame = CGRectMake(horizontalOffset, 0.0, buttonWidth, button.frame.size.height);
        
        CGSize dividerSize = self.dividerImg.size;
        if (i != buttons.count - 1)
        {
            UIImageView *divider = dividers[i];
            divider.frame = CGRectMake(horizontalOffset + buttonWidth, 0.0, dividerSize.width, dividerSize.height);
        }
        
        // Advance the horizontal offset
        horizontalOffset = horizontalOffset + buttonWidth + dividerSize.width;
    }    
}

-(void) dimAllButtonsExcept:(UIButton*)selectedButton
{
    for (UIButton* button in buttons)
    {
        if (button == selectedButton)
        {
            button.selected = YES;
            button.highlighted = button.selected ? NO : YES;
        }
        else
        {
            button.selected = NO;
            button.highlighted = NO;
        }
    }
}

- (void)touchDownAction:(UIButton*)button
{
    [self dimAllButtonsExcept:button];
    
    if ([delegate respondsToSelector:@selector(touchDownAtSegmentIndex:)])
        [delegate touchDownAtSegmentIndex:[buttons indexOfObject:button]];
}

- (void)touchUpInsideAction:(UIButton*)button
{
    [self dimAllButtonsExcept:button];
    
    if ([delegate respondsToSelector:@selector(touchUpInsideSegmentIndex:)])
        [delegate touchUpInsideSegmentIndex:[buttons indexOfObject:button]];
}

- (void)otherTouchesAction:(UIButton*)button
{
    [self dimAllButtonsExcept:button];
}


@end
