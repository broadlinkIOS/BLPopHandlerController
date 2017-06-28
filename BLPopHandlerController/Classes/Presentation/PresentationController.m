//
//  CustomPresentationVc.m
//  PrensentSample
//
//  Created by BroadLink on 2017/6/19.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import "PresentationController.h"

@interface PresentationController()
@property (nonatomic, strong) UIVisualEffectView *dimmingView;
@end

@implementation PresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    return [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
}

- (void)presentationTransitionWillBegin
{
    [self setupDimmingView];
    [self.containerView addSubview:_dimmingView];
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (!completed) {
        [_dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin
{
    _dimmingView.alpha = 0.0;
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed) {
        [_dimmingView removeFromSuperview];
    }
}

- (void)containerViewWillLayoutSubviews
{
    _dimmingView.center = self.containerView.center;
    _dimmingView.bounds = self.containerView.bounds;
    self.presentedView.frame = self.frameOfPresentedViewInContainerView;
}

- (void)setupDimmingView
{
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _dimmingView = [[UIVisualEffectView alloc]initWithEffect:effect];
    _dimmingView.alpha = 0.4;
    _dimmingView.center = self.containerView.center;
    _dimmingView.bounds = self.containerView.bounds;
}

@end
