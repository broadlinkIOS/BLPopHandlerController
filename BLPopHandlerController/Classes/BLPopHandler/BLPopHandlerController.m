//
//  BLPopControlView.m
//  ihc
//
//  Created by apple on 2017/4/5.
//  Copyright © 2017年 broadlink. All rights reserved.
//

#import "BLPopHandlerController.h"
#import "BLPopHandlerTransition.h"
#import "BLPopControlViewButton.h"

#define kRadius             [[UIScreen mainScreen]bounds].size.width * 120.0f / 320.0f
#define kSubButtonSize      CGSizeMake(51 + 20.0f, 51 + 20.0f + 10.0f)
#define kFontSize           12.0f
#define kFontColor          [UIColor whiteColor]

@interface BLPopAction()
@property (nullable, nonatomic, readwrite) NSString *title;
@property (nullable, nonatomic, readwrite) UIImage *image;
@property (nonatomic, readwrite) BLPopActionStyle style;
@property (nonatomic, copy) void (^event)(BLPopAction *action);
@end

@implementation BLPopAction

+ (instancetype)actionWithTitle:(nullable NSString *)title withImage:(UIImage *)image style:(BLPopActionStyle)style handler:(void (^__nullable)(BLPopAction *action))handler
{
    BLPopAction *action = [[BLPopAction alloc]init];
    action.title = title;
    action.image = image;
    action.style = style;
    action.event = handler;
    return action;
}

@end


@interface BLPopHandlerController ()
@property (nonatomic, readwrite) NSMutableArray<BLPopAction *> *actions;
@property (nonatomic, readwrite) CGRect imageViewFrame;
@property (nonatomic, strong) NSMutableArray *buttonArr;
@property (nonatomic, strong) NSMutableArray *lineImgVArray;
@property (nonatomic, strong) BLPopHandlerTransition *transition;
@property (nonatomic, strong) UIImageView *centerImageView;
@end

@implementation BLPopHandlerController

+ (instancetype)popControllerWithCenterImage:(UIImage *)centerImage originFrame:(CGRect)originFrame
{
    BLPopHandlerController *vc = [[BLPopHandlerController alloc] init];
    vc.centerImageView = [[UIImageView alloc]init];
    vc.centerImageView.image = centerImage;
    vc.centerImageView.frame = CGRectMake(0, 0, 150, 150);
    vc.centerImageView.center = vc.view.center;
    [vc.view addSubview:vc.centerImageView];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transition = [[BLPopHandlerTransition alloc] initOriginFrame:originFrame];
    vc.transitioningDelegate = vc.transition;
    
    return vc;
}

+ (instancetype)popControllerWithCenterImage:(UIImage *)centerImage originFrame:(CGRect)originFrame finalFrame:(CGRect)finalFrame
{
    BLPopHandlerController *vc = [[BLPopHandlerController alloc] init];
    vc.centerImageView = [[UIImageView alloc]init];
    vc.centerImageView.image = centerImage;
    vc.centerImageView.frame = finalFrame;
    [vc.view addSubview:vc.centerImageView];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transition = [[BLPopHandlerTransition alloc] initOriginFrame:originFrame];
    vc.transitioningDelegate = vc.transition;
    
    return vc;
}

- (void)addAction:(BLPopAction *)action
{
    if(_actions == nil){
        _actions = [[NSMutableArray alloc]init];
    }
    [_actions addObject:action];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(_radius == 0.f) _radius = kRadius;
    if(CGSizeEqualToSize(_subButtonSize, CGSizeZero)) _subButtonSize = kSubButtonSize;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showSubButton];
}

- (void)showSubButton
{
    if (!self.buttonArr) {
        self.buttonArr = [NSMutableArray arrayWithCapacity:0];
    } else {
        [self.buttonArr removeAllObjects];
    }
    if (!self.lineImgVArray) {
        self.lineImgVArray = [NSMutableArray arrayWithCapacity:0];
    } else {
        [self.lineImgVArray removeAllObjects];
    }
    
    for (int i = 0; i < self.actions.count; i++) {
        UIButton *button = [self buttonWithTitle:self.actions[i].title index:i image:self.actions[i].image];
        [self.buttonArr addObject:button];
        [self.view addSubview:button];
    }
    
    int angle = 360 / self.buttonArr.count;
    float radian = angle * M_PI / 180.0;
    float centerX = self.centerImageView.center.x;
    float centerY = self.centerImageView.center.y;
    
    [UIView animateWithDuration:0.3f animations:^{
        for (int i = 0; i < self.buttonArr.count; i++) {
            UIButton *button = self.buttonArr[i];
            float x = centerX + _radius * sinf(radian * (i + 1));
            float y = centerY + _radius * cosf(radian * (i + 1));
            button.center = CGPointMake(x, y);
            button.alpha = 1.0f;
            [self.lineImgVArray addObject:[self drawLineFromAngle:angle andCenterX:centerX andCenterY:centerY andRadian:radian andIndex:i andInView:self.view]];
        }
        
    } completion:^(BOOL finished) {
        
    }];
}

- (UIButton *)buttonWithTitle:(NSString *)title index:(NSInteger)index image:(UIImage *)image
{
    UIButton *button = [BLPopControlViewButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:kFontSize]];
    [button setTitleColor:kFontColor forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setBounds:CGRectMake(0, 0, _subButtonSize.width, _subButtonSize.height)];
    button.center = self.centerImageView.center;
    [button setImage:image forState:UIControlStateNormal];
     
    return button;
}

- (void)btnClick:(UIButton *)btn
{
    if(_actions[btn.tag].style == BLPopActionMore)
        [self dismissViewControllerAnimated:NO completion:nil];
    
    _actions[btn.tag].event(_actions[btn.tag]);
}

- (UIImageView *)drawLineFromAngle:(int)angle andCenterX:(float)centerX andCenterY:(float)centerY andRadian:(float)radian andIndex:(int)idx andInView:(UIView *)view
{
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:view.frame];
    [view addSubview:lineView];
    
    CGPoint start;
    CGPoint end;
    float tmpAngle = angle * (idx + 1);
    float tmpX = _radius * sinf(radian * (idx + 1));
    float tmpY = _radius * cosf(radian * (idx + 1));
    if (tmpAngle > 0 && tmpAngle < 90.0f) {
        start = CGPointMake(centerX + tmpX / 2 + 3.0f, centerY + tmpY / 2 + 3.0f);
        end   = CGPointMake(centerX + tmpX / 2 + 12.0f, centerY + tmpY / 2 + 12.0f);
    } else if (tmpAngle > 90.0f && tmpAngle < 180.0f) {
        start = CGPointMake(centerX + tmpX / 2 + 3.0f, centerY + tmpY / 2 - 3.0f);
        end   = CGPointMake(centerX + tmpX / 2 + 12.0f, centerY + tmpY / 2 - 12.0f);
    } else if (tmpAngle > 180.0f && tmpAngle < 270.0f) {
        start = CGPointMake(centerX + tmpX / 2 - 3.0f, centerY + tmpY / 2 - 3.0f);
        end   = CGPointMake(centerX + tmpX / 2 - 12.0f, centerY + tmpY / 2 - 12.0f);
    } else if ((tmpAngle > 270.0f && tmpAngle < 360.0f)) {
        start = CGPointMake(centerX + tmpX / 2 - 3.0f, centerY + tmpY / 2 + 3.0f);
        end   = CGPointMake(centerX + tmpX / 2 - 12.0f, centerY + tmpY / 2 + 12.0f);
    } else if (tmpAngle == 360.0f || tmpAngle == 0.0f) {
        start = CGPointMake(centerX, centerY + tmpY / 2 + 3.0f);
        end   = CGPointMake(centerX, centerY + tmpY / 2 + 18.0f);
    } else if (tmpAngle == 180.0f) {
        start = CGPointMake(centerX, centerY + tmpY / 2 - 3.0f);
        end   = CGPointMake(centerX, centerY + tmpY / 2 - 18.0f);
    } else if (tmpAngle == 90.0f) {
        start = CGPointMake(centerX + tmpX / 2 + 3.0f, centerY);
        end   = CGPointMake(centerX + tmpX / 2 + 18.0f, centerY);
    } else if (tmpAngle == 270.0f) {
        start = CGPointMake(centerX + tmpX / 2 - 3.0f, centerY);
        end   = CGPointMake(centerX + tmpX / 2 - 18.0f, centerY);
    }
    
    UIGraphicsBeginImageContext(lineView.frame.size);
    [lineView.image drawInRect:CGRectMake(0, 0, lineView.frame.size.width, lineView.frame.size.height)];
    [lineView setBackgroundColor:[UIColor clearColor]];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapSquare);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.3);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 255, 255, 255, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), start.x, start.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), end.x, end.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    lineView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return lineView;
}

- (void)dismissView
{
    int angle = 360 / self.buttonArr.count;
    float radian = angle * M_PI / 180.0;
    [UIView animateWithDuration:0.3f animations:^{
        for (int i = 0; i < self.buttonArr.count; i++) {
            UIButton *button = self.buttonArr[i];
            float x = button.center.x - _radius * sinf(radian * (i + 1));
            float y = button.center.y - _radius * cosf(radian * (i + 1));
            button.center = CGPointMake(x, y);
            button.alpha = 0.0f;
            [self.lineImgVArray removeAllObjects];
        }
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_isDissmissBlock) {
        [self dismissView];
    }
    else if (_isDissmissBlock()) {
        [self dismissView];
    }
}

@end
