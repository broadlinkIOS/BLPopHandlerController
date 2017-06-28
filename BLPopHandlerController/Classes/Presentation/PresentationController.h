//
//  CustomPresentationVc.h
//  PrensentSample
//
//  Created by BroadLink on 2017/6/19.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresentationController : UIPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController;

@end
