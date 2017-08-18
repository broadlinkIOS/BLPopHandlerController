//
//  BLViewController.m
//  BLPopHandlerController
//
//  Created by upupSue on 06/28/2017.
//  Copyright (c) 2017 upupSue. All rights reserved.
//

#import "BLViewController.h"
#import <BLPopHandlerController/BLPopHandlerController.h>

@interface BLViewController (){
    UIImageView *imgView;
}

@end

@implementation BLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 100, 50, 50)];
    imgView.image = [UIImage imageNamed:@"image"];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageViewTap)];
    [imgView addGestureRecognizer:tap];
    
    [self.view addSubview:imgView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:YES];
}

- (void)onImageViewTap
{
//    BLPopHandlerController *vc = [BLPopHandlerController popControllerWithCenterImage:[imgView image] originFrame:[imgView.superview convertRect:imgView.frame toView:nil]];
    
    BLPopHandlerController *vc = [BLPopHandlerController popControllerWithCenterImage:[imgView image] originFrame:[imgView.superview convertRect:imgView.frame toView:nil] finalFrame:CGRectMake(100, 200, 100, 100)];
                                      
    [vc addAction:[BLPopAction actionWithTitle:@"aaa" withImage:[UIImage imageNamed:@"imga"] style:BLPopActionDefault handler:^(BLPopAction * _Nonnull action){
        NSLog(@"aaa");
    }]];
    [vc addAction:[BLPopAction actionWithTitle:@"bbb" withImage:[UIImage imageNamed:@"imgb"] style:BLPopActionDefault handler:^(BLPopAction * _Nonnull action){
        NSLog(@"bbb");
    }]];
    [vc addAction:[BLPopAction actionWithTitle:@"ccc" withImage:[UIImage imageNamed:@"imge"] style:BLPopActionDefault handler:^(BLPopAction * _Nonnull action){
        NSLog(@"ccc");
    }]];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setBounds:CGRectMake(0, 0, 50, 60)];
    [btn setImage:[UIImage imageNamed:@"imgd"] forState:UIControlStateNormal];
    [vc addAction:[BLPopAction actionWithCustomizeButton:btn style:BLPopActionDefault handler:^(BLPopAction * _Nonnull action){
        NSLog(@"ddd");
    }]];
    [vc addAction:[BLPopAction actionWithTitle:@"more" withImage:[UIImage imageNamed:@"imgc"] style:BLPopActionMore handler:^(BLPopAction * _Nonnull action){
        NSLog(@"more");
    }]];
    
    vc.radius = 100;
    vc.subButtonSize = CGSizeMake(50, 60);
    __block int i = 0;
    vc.isDissmissBlock = ^(){
        if(i == 0){
            i++;
            return NO;
        }
        else return YES;
    };
    
    [self presentViewController:vc animated:YES completion:^{
    }];
}

@end
