#import "Deal.h"

@implementation Deal

@synthesize title;
@synthesize image;
@synthesize imageName;
@synthesize details;
@synthesize featuredDetails;
@synthesize contents;

+ (Deal *)dealWithData:(NSDictionary *)data {
    Deal *deal = [[Deal alloc] init];
    deal.title = data[@"title"];
    deal.imageName = data[@"imageName"];
    deal.image = deal.imageName ? [UIImage imageNamed:deal.imageName] : nil;
    deal.details = data[@"details"];
    deal.featuredDetails = data[@"featuredDetails"];
    deal.contents = data[@"contents"];
    
    return deal;
}

@end
