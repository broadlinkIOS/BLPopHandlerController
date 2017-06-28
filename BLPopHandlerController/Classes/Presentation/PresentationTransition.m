//
//  PresentationTransition.m
//  PrensentSample
//
//  Created by BroadLink on 2017/6/20.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import "PresentationTransition.h"
#import "PresentationController.h"
#import "PresentationAnimation.h"

@interface PresentationTransition ()
@property (nonatomic, strong) PresentationAnimation *presentAnimation;
@end

@implementation PresentationTransition

- (id)initOriginFrame:(CGRect)oriFrame{
    _originFrame = oriFrame;
    return [super init];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[PresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [self generateAnimatorWithPresenting:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [self generateAnimatorWithPresenting:NO];
}

- (PresentationAnimation *)generateAnimatorWithPresenting:(BOOL)presenting
{
    if (!_presentAnimation) {
        _presentAnimation = [[PresentationAnimation alloc]init];
    }
    _presentAnimation.presenting = presenting;
    _presentAnimation.originFrame = _originFrame;
    return _presentAnimation;
}

- (PresentationAnimation *)presentAnimation
{
    if (!_presentAnimation) {
        _presentAnimation = [[PresentationAnimation alloc]init];
    }
    return _presentAnimation;
}

@end
