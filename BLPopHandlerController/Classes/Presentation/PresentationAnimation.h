//
//  PresentationAnimation.h
//  PrensentSample
//
//  Created by BroadLink on 2017/6/19.
//  Copyright © 2017年 方琼蔚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PresentationAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL presenting;
@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, assign) CGRect finalFrame;
@end
