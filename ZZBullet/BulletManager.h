//
//  BulletManager.h
//  CommentDemo
//
//  Created by 张真 on 17/3/14.
//  Copyright © 2017年 张真. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BulletView;
@interface BulletManager : NSObject

@property (copy, nonatomic) void(^generateViewBlock)(BulletView *view);
//弹幕开始
- (void)start;
//弹幕结束
- (void)stop;

@end
