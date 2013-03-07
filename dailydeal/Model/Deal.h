#import <Foundation/Foundation.h>

@interface Deal : NSObject

@property (nonatomic, strong) NSString      *title;
@property (nonatomic, strong) UIImage       *image;
@property (nonatomic, strong) NSString      *imageName;
@property (nonatomic, strong) NSDictionary  *details;
@property (nonatomic, strong) NSArray       *featuredDetails;
@property (nonatomic, strong) NSArray       *contents;

+ (Deal *)dealWithData:(NSDictionary *)data;

@end
