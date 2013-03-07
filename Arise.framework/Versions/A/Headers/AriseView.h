//
// Copyright 2012 Twitter
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <UIKit/UIKit.h>
#import <Arise/AriseConf.h>
#import <Arise/AriseStats.h>
#import <Arise/AriseUtils.h>
#import <Arise/AriseLoadingView.h>

@interface AriseView : UIView <UIScrollViewDelegate, UIWebViewDelegate> {
    UIWebView *_webView;
    NSMutableArray *_methodQueue;
    CFAbsoluteTime _lastBottomReached;
    BOOL _loaded;
}

@property (nonatomic, retain) NSString *slug;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) AriseLoadingView *loadingView;
@property (nonatomic, retain) id scrollViewOriginalDelegate;
@property (nonatomic, retain) id scrollDelegate;
@property (nonatomic, retain) id delegate;

- (void)loadWebView;
- (void)callMethod:(NSString *)method;
- (void)callMethod:(NSString *)method withParams:(NSDictionary *)params;
- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame andSlug:(NSString *)slug;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
+ (void)logDeviceIdentifier;
+ (NSString *)getDeviceIdentifier;
+ (void)prepareForAnimation:(UIViewController *)viewController success:(void(^)(void))block_;
+ (void)prepareForDisplay:(UIViewController *)viewController success:(void(^)(void))block_;
+ (void)prepareForDisplay:(UIViewController *)viewController;

@end

@protocol AriseViewDelegate
@optional
- (void)AriseView:(AriseView *)AriseView methodCalled:(NSString *)method withParams:(NSDictionary *)params;
- (void)AriseView:(AriseView *)AriseView methodCalled:(NSString *)method withParams:(NSDictionary *)params callback:(void(^)(id))callback;
@end
