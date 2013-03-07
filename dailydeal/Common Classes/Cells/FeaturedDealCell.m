#import "FeaturedDealCell.h"

@implementation FeaturedDealCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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
    CGRect bkgBounds = self.bounds;
    bkgBounds.origin.x = 10;
    bkgBounds.size.width -= 20;
    UIImage *imageBkg = [UIImage imageNamed:@"deal-detail-box.png"];
    UIImageView *viewBack = [[UIImageView alloc] initWithImage:[imageBkg stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    viewBack.frame = bkgBounds;
    self.backgroundView = viewBack;
    
    UIImage *imgMask = [UIImage imageNamed:@"image-mask.png"];
    UIImageView *viewMask = [[UIImageView alloc] initWithImage:[imgMask stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    [self addSubview:viewMask];
    
    
}

@end
