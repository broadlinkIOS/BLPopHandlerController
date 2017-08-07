//
//  PresentationTransition.h
//  PrensentSample
//
//  Created by BroadLink on 2017/6/20.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BLPopHandlerTransition : NSObject<UIViewControllerTransitioningDelegate>

- (id)initOriginFrame:(CGRect)oriFrame;
@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, assign) CGRect finalFrame;

@end
