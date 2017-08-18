//
//  BLPopControlView.h
//  ihc
//
//  Created by apple on 2017/4/5.
//  Copyright © 2017年 broadlink. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef BOOL (^IsDissmissBlock)();

@interface BLPopAction : NSObject

+ (instancetype)actionWithTitle:(nullable NSString *)title withImage:(UIImage *)image handler:(void (^__nullable)(BLPopAction *action))handler;
+ (instancetype)actionWithCustomizeButton:(UIButton *)button handler:(void (^__nullable)(BLPopAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nullable, nonatomic, readonly) UIImage *image;
@property (nullable, nonatomic, readonly) UIButton *button;

@end


@interface BLPopHandlerController: UIViewController

+ (instancetype)popControllerWithCenterImage:(UIImage *)centerImage originFrame:(CGRect)originFrame;
+ (instancetype)popControllerWithCenterImage:(UIImage *)centerImage originFrame:(CGRect)originFrame finalFrame:(CGRect)finalFrame;
- (void)addAction:(BLPopAction *)action;

@property (nonatomic, readonly) NSArray<BLPopAction *> *actions;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, assign) CGFloat radius;                                   //子按钮距中心图片呈圆形散开的半径
@property (nonatomic, assign) CGSize subButtonSize;
@property (nonatomic, copy) IsDissmissBlock isDissmissBlock;                    //如果设置该block 将在点击空白处时执行该block，block返回yes时dismissView

@end

NS_ASSUME_NONNULL_END
