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
    BLPopHandlerController *popHandlerController;
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
    popHandlerController = [BLPopHandlerController popControllerWithCenterImage:[imgView image] originFrame:[imgView.superview convertRect:imgView.frame toView:nil]];
                                      
    [popHandlerController addAction:[BLPopAction actionWithTitle:@"aaa" withImage:[UIImage imageNamed:@"imga"] handler:^(BLPopAction * _Nonnull action){
        NSLog(@"aaa");
    }]];
    [popHandlerController addAction:[BLPopAction actionWithTitle:@"bbb" withImage:[UIImage imageNamed:@"imgb"] handler:^(BLPopAction * _Nonnull action){
        NSLog(@"bbb");
    }]];
    [popHandlerController addAction:[BLPopAction actionWithTitle:@"ccc" withImage:[UIImage imageNamed:@"imge"] handler:^(BLPopAction * _Nonnull action){
        NSLog(@"ccc");
    }]];
    
    
    UIButton *button = [[UIButton alloc] init];
    [button setBounds:CGRectMake(0, 0, 50, 60)];
    [button setImage:[UIImage imageNamed:@"imgd"] forState:UIControlStateNormal];
    [button setTitle:@"ddd" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [popHandlerController addAction:[BLPopAction actionWithCustomizeButton:button handler:^(BLPopAction * _Nonnull action){
        NSLog(@"ddd");
    }]];
    
    
    __block BLPopHandlerController *hvc = popHandlerController;
    [popHandlerController addAction:[BLPopAction actionWithTitle:@"more" withImage:[UIImage imageNamed:@"imgc"] handler:^(BLPopAction * _Nonnull action){
        NSLog(@"more");
        [hvc dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"dismiss");
    }]];
    
//    vc.radius = 100;
//    vc.subButtonSize = CGSizeMake(50, 60);
    __block int i = 0;
    popHandlerController.isDissmissBlock = ^(){
        if(i == 0){
            i++;
            return NO;
        }
        else return YES;
    };
    
    [self presentViewController:popHandlerController animated:YES completion:nil];
}

@end
