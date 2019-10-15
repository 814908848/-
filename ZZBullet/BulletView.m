//
//  BulletView.m
//  CommentDemo
//
//  Created by 张真 on 17/3/14.
//  Copyright © 2017年 张真. All rights reserved.
//

#import "BulletView.h"
#define Padding 10
#define PhotoHeight 30
@interface BulletView()

@property (strong, nonatomic) UILabel *lbComment;

@property (strong, nonatomic) UIImageView *photoImageView;

@end

@implementation BulletView

//初始化弹幕
- (instancetype)initWithComment:(NSString *)comment
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = 15;
        NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
        CGFloat width = [comment sizeWithAttributes:attr].width;
        self.bounds = CGRectMake(0, 0, width + 2 * Padding + PhotoHeight, 30);
        self.lbComment.text = comment;
        self.lbComment.frame = CGRectMake(Padding + PhotoHeight, 0, width, 30);
        self.photoImageView.frame = CGRectMake(-Padding, -Padding + (PhotoHeight + Padding - CGRectGetHeight(self.lbComment.frame)) / 2, PhotoHeight + Padding, PhotoHeight + Padding);
        self.photoImageView.layer.cornerRadius = (PhotoHeight + Padding) / 2;
        self.photoImageView.layer.borderColor = [UIColor orangeColor].CGColor;
        self.photoImageView.layer.borderWidth = 1;
        self.photoImageView.image = [UIImage imageNamed:@"AppIcon57x57@2x"];
    }
    return self;
}
//开始动画
- (void)startAnimation
{
    //根据弹幕长度执行动画效果
    //根据 v = s / t
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0f;
    CGFloat wholeWidth = screenWidth + CGRectGetWidth(self.bounds);
    
    if (self.moveStatusBlock) {
        self.moveStatusBlock(MoveStatusStart);
    }
    CGFloat speed = wholeWidth / duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds) / speed;
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    __block CGRect frame = self.frame;
    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.moveStatusBlock) {
            self.moveStatusBlock(MoveStatusEnd);
        }
    }];
}
- (void)enterScreen
{
    if (self.moveStatusBlock) {
        self.moveStatusBlock(MoveStatusEnter);
    }
}
//结束动画
- (void)stopAnimation
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}
- (UILabel *)lbComment
{
    if (!_lbComment) {
        _lbComment = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        _lbComment.textColor = [UIColor whiteColor];
        [self addSubview:_lbComment];
    }
    return _lbComment;
}
- (UIImageView *)photoImageView
{
    if (_photoImageView == nil) {
        _photoImageView = [[UIImageView alloc]init];
        _photoImageView.clipsToBounds = YES;
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_photoImageView];
    }
    return _photoImageView;
}
@end
