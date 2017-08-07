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
    BLPopHandlerController *vc = [BLPopHandlerController popControllerWithCenterImage:[imgView image] originFrame:[imgView.superview convertRect:imgView.frame toView:nil]];
    [vc addAction:[BLPopAction actionWithTitle:@"aaa" withImage:[UIImage imageNamed:@"imga"] style:BLPopActionDefault handler:^(BLPopAction * _Nonnull action){
        NSLog(@"aaa");
    }]];
    [vc addAction:[BLPopAction actionWithTitle:@"bbb" withImage:[UIImage imageNamed:@"imgb"] style:BLPopActionDefault handler:^(BLPopAction * _Nonnull action){
        NSLog(@"bbb");
    }]];
    [vc addAction:[BLPopAction actionWithTitle:@"ccc" withImage:[UIImage imageNamed:@"imge"] style:BLPopActionDefault handler:^(BLPopAction * _Nonnull action){
        NSLog(@"ccc");
    }]];
    [vc addAction:[BLPopAction actionWithTitle:@"ddd" withImage:[UIImage imageNamed:@"imgd"] style:BLPopActionDefault handler:^(BLPopAction * _Nonnull action){
        NSLog(@"ddd");
    }]];
    [vc addAction:[BLPopAction actionWithTitle:@"more" withImage:[UIImage imageNamed:@"imgc"] style:BLPopActionMore handler:^(BLPopAction * _Nonnull action){
        NSLog(@"more");
    }]];
    [self presentViewController:vc animated:YES completion:^{
    }];
}

@end
