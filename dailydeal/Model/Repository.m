#import "Repository.h"
#import "Deal.h"

@implementation Repository

+ (NSArray *)loadDemoData {
    Deal *item1 = [Deal dealWithData:@{@"title": @"Cucumber"
                   , @"imageName": @"cucumber.jpg"
                   , @"details": @{@"Price": @"€3.00"
                   , @"Discount": @"-10%"
                   , @"Savings": @"€0.30"
                   , @"Quantity": @"each"
                   , @"Opens": @"21.02.2012"}
                   , @"featuredDetails": @[@"Price", @"Discount", @"Savings", @"Quantity"]
                   , @"contents": @[@"Fresh cucumbers"
                   , @"Ideal for sandwiches and salads"]}];
    Deal *item2 = [Deal dealWithData:@{@"title": @"Carrots"
                   , @"imageName": @"carrots.jpg"
                   , @"details": @{@"Price": @"€2.00"
                   , @"Discount": @"-10%"
                   , @"Savings": @"€0.20"
                   , @"Quantity": @"/kg"
                   , @"Opens": @"21.02.2012"}
                   , @"featuredDetails": @[@"Price", @"Discount", @"Savings", @"Quantity"]
                   , @"contents": @[@"Organic carrots"
                   , @"Visit our website for a recipe for delicioius organic carrot soup"]}];
    Deal *item3 = [Deal dealWithData:@{@"title": @"Potatoes"
                   , @"imageName": @"potatoes.jpg"
                   , @"details": @{@"Price": @"€5.00"
                   , @"Discount": @"-10%"
                   , @"Savings": @"€0.50"
                   , @"Quantity": @"10 kg bag"
                   , @"Opens": @"21.02.2012"}
                   , @"featuredDetails": @[@"Price", @"Discount", @"Savings", @"Quantity"]
                   , @"contents": @[@"Big bag of spuds!"
                   , @"Maris Piper Potatoes, perfect for mash, roasting, boiling, chipping..."]}];
    Deal *item4 = [Deal dealWithData:@{@"title": @"Tomatoes"
                   , @"imageName": @"tomato.jpg"
                   , @"details": @{@"Price": @"€3.50"
                   , @"Discount": @"-10%"
                   , @"Savings": @"€0.35"
                   , @"Quantity": @"punnet of s6"
                   , @"Opens": @"21.02.2012"}
                   , @"featuredDetails": @[@"Price", @"Discount", @"Savings", @"Quantity"]
                   , @"contents": @[@"Organic Tomatoes"
                   , @"On the vine, for extra freshness."]}];
    
    NSArray *data = @[item1, item2, item3, item4];
    return data;
}


@end
