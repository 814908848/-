//
//  BulletView.h
//  CommentDemo
//
//  Created by 张真 on 17/3/14.
//  Copyright © 2017年 张真. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    MoveStatusStart,
    MoveStatusEnter,
    MoveStatusEnd
} MoveStatus;
@interface BulletView : UIView
@property (assign, nonatomic) int trajectory;//弹道
@property (copy, nonatomic) void(^moveStatusBlock)(MoveStatus status);//弹幕状态回调
//初始化弹幕
- (instancetype)initWithComment:(NSString *)comment;
//开始动画
- (void)startAnimation;
//结束动画
- (void)stopAnimation;
@end
