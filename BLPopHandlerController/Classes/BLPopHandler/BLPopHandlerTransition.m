//
//  PresentationTransition.m
//  PrensentSample
//
//  Created by BroadLink on 2017/6/20.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import "BLPopHandlerTransition.h"
#import "BLPopHandlerBlurController.h"
#import "BLPopHandlerAnimation.h"

@interface BLPopHandlerTransition ()
@property (nonatomic, strong) BLPopHandlerAnimation *presentAnimation;
@end

@implementation BLPopHandlerTransition

- (id)initOriginFrame:(CGRect)oriFrame
{
    _originFrame = oriFrame;
    return [super init];
}

- (BLPopHandlerBlurController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[BLPopHandlerBlurController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [self generateAnimatorWithPresenting:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [self generateAnimatorWithPresenting:NO];
}

- (BLPopHandlerAnimation *)generateAnimatorWithPresenting:(BOOL)presenting
{
    if (!_presentAnimation) {
        _presentAnimation = [[BLPopHandlerAnimation alloc] init];
    }
    _presentAnimation.presenting = presenting;
    _presentAnimation.originFrame = _originFrame;
    return _presentAnimation;
}

- (BLPopHandlerAnimation *)presentAnimation
{
    if (!_presentAnimation) {
        _presentAnimation = [[BLPopHandlerAnimation alloc] init];
    }
    return _presentAnimation;
}

@end
