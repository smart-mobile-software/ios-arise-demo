#import "DetailCell.h"

@implementation DetailCell

@synthesize textLabel;
@synthesize detailLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.detailLabel.textColor = [UIColor blackColor];
        self.detailLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.textLabel];
        [self addSubview:self.detailLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat viewHeight = self.bounds.size.height;
    CGSize labelTextSize = [self.textLabel.text sizeWithFont:
                             [UIFont systemFontOfSize:[UIFont systemFontSize]]];
    CGSize labelDetailSize = [self.detailLabel.text sizeWithFont:
                             [UIFont systemFontOfSize:[UIFont systemFontSize]]];
    self.textLabel.frame = CGRectIntegral(CGRectMake(0, 
                                                     (viewHeight-labelTextSize.height)/2,
                                                     120, 
                                                     labelTextSize.height));
    self.detailLabel.frame = CGRectIntegral(CGRectMake(125, 
                                                     (viewHeight-labelDetailSize.height)/2,
                                                     120, 
                                                     labelDetailSize.height));
}

@end
