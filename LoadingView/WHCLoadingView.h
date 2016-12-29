//
//  WHCLoadingView.h
//  WHCAPP
//
//  Created by Haochen Wang on 11/30/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#define ShowNetworkActivityIndicator      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO

#define kBackView         for (UIView *item in KEYWindow.subviews) { \
if(item.tag == 10000) \
{ \
[item removeFromSuperview]; \
} \
} \
UIView * aView = [[UIView alloc] init]; \
aView.frame = [UIScreen mainScreen].bounds; \
aView.tag = 10000; \
aView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3]; \
[KEYWindow addSubview:aView]; \

#define kRemoveBackView         for (UIView *item in KEYWindow.subviews) { \
if(item.tag == 10000) \
{ \
[UIView animateWithDuration:0.4 animations:^{ \
item.alpha = 0.0; \
} completion:^(BOOL finished) { \
[item removeFromSuperview]; \
}]; \
} \
} \

#define ShowWHCLoadingView kBackView;[WHCLoadingView showLoading];ShowNetworkActivityIndicator

#define HideWHCLoadingView kRemoveBackView;[WHCLoadingView hideLoading];HideNetworkActivityIndicator

#import <UIKit/UIKit.h>
#import "WHCConstants.h"

@interface WHCLoadingView : UIView

SINGLETON_interface(WHCLoadingView)

+(void)showLoading;

+(void)hideLoading;

@end
