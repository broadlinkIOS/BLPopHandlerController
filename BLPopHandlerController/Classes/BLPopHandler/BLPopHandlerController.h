//
//  BLPopControlView.h
//  ihc
//
//  Created by apple on 2017/4/5.
//  Copyright © 2017年 broadlink. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLPopAction : NSObject

+ (instancetype)actionWithTitle:(nullable NSString *)title
                      withImage:(UIImage *)image
                        handler:(void (^__nullable)(BLPopAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nullable, nonatomic, readonly) UIImage *image;

@end


@interface BLPopHandlerController: UIViewController

+ (instancetype)popControllerWithCenterImage:(UIImage *)centerImage originFrame:(CGRect)originFrame;
- (void)addAction:(BLPopAction *)action;

@property (nonatomic, readonly) NSArray<BLPopAction *> *actions;

@end

NS_ASSUME_NONNULL_END
