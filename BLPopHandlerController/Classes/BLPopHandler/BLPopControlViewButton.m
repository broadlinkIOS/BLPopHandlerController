//
//  BLPopControlViewButton.m
//  ihc
//
//  Created by apple on 2017/4/5.
//  Copyright © 2017年 broadlink. All rights reserved.
//

#import "BLPopControlViewButton.h"

@implementation BLPopControlViewButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 12);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(10, 0, self.bounds.size.width - 20 ,self.bounds.size.width - 20);
}

@end
