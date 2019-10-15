//
//  BulletManager.m
//  CommentDemo
//
//  Created by 张真 on 17/3/14.
//  Copyright © 2017年 张真. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"
@interface BulletManager()
//弹幕的数据来源
@property (strong, nonatomic) NSMutableArray *dataSource;
//弹幕使用过程中的数组变量
@property (strong, nonatomic) NSMutableArray *bulletComments;
//存储弹幕View的数组变量
@property (strong, nonatomic) NSMutableArray *bulletViews;

@property (assign, nonatomic) BOOL bStopAnimation;
@end

@implementation BulletManager
- (instancetype)init
{
    if (self = [super init]) {
        self.bStopAnimation = YES;
    }
    return self;
}
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"弹幕1~~~~~~~~~~",@"弹幕2~~~~~~~",@"弹幕3~~~~~~~~~~~~~~~",@"弹幕4~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",@"弹幕5~~~~~~~~~~",@"弹幕6~~~~~~~",@"弹幕7~~~~~~~~~~~~~~~",@"弹幕8~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",@"弹幕9~~~~~~~~~~"]];
    }
    return _dataSource;
}
- (NSMutableArray *)bulletComments
{
    if (_bulletComments == nil) {
        _bulletComments = [NSMutableArray array];
    }
    return _bulletComments;
}
- (NSMutableArray *)bulletViews
{
    if (_bulletViews == nil) {
        _bulletViews = [NSMutableArray array];
    }
    return _bulletViews;
}
-(void)start
{
    if (!self.bStopAnimation) {
        return;
    }
    self.bStopAnimation = NO;
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.dataSource];
    [self initBulletComment];
}
//初始化弹幕，随机分配弹幕轨迹
- (void)initBulletComment
{
    NSMutableArray *trajectorys = [NSMutableArray arrayWithArray:@[@0,@1,@2]];
    for (int i = 0; i < 3; i ++) {
        if (self.bulletComments.count > 0) {
            
            //通过随机数取出弹幕的轨迹
            NSInteger index = arc4random() % trajectorys.count;
            int trajectory = [[trajectorys objectAtIndex:index] intValue];
            [trajectorys removeObjectAtIndex:index];
            //从弹幕数组中逐一取出弹幕数据
            NSString *comment = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];
            //创建弹幕view
            [self createBulletView:comment trajectory:trajectory];
        }
    }
}
- (void)createBulletView:(NSString *)comment trajectory:(int)trajectory
{
    if (self.bStopAnimation) {
        return;
    }
    BulletView *view = [[BulletView alloc]initWithComment:comment];
    view.trajectory = trajectory;
    [self.bulletViews addObject:view];
    __weak typeof(self) weakSelf = self;
    __weak typeof(view) weakView = view;
    view.moveStatusBlock = ^(MoveStatus status){
        if (self.bStopAnimation) {
            return ;
        }
        switch (status) {
            case MoveStatusStart:
            {
                //弹幕开始进入屏幕，将View加入弹幕管理的变量中bulletViews
                [weakSelf.bulletViews addObject:weakView];
            }
                break;
            case MoveStatusEnter:
            {
                //弹幕完全进入屏幕，判断是否还有其他内容，如果有则在该弹幕轨迹中创建一个弹幕
                NSString *comment = [weakSelf nextComment];
                if (comment) {
                    [weakSelf createBulletView:comment trajectory:trajectory];
                }
            }
                break;
            case MoveStatusEnd:
            {
                //弹幕完全废除屏幕后，需要从bulletViews中删除，释放资源
                if ([weakSelf.bulletViews containsObject:weakView]) {
                    [weakView stopAnimation];
                    [weakSelf.bulletViews removeObject:weakView];
                }
                if (weakSelf.bulletViews.count == 0) {
                    //说明屏幕上已经没有弹幕了，开始循环滚动
                    self.bStopAnimation = YES;
                    [weakSelf start];
                }
            }
                break;
                
            default:
                break;
        }
    };
    if (self.generateViewBlock) {
        self.generateViewBlock(view);
    }
}
- (NSString *)nextComment
{
    NSString *comment = [self.bulletComments firstObject];
    if (self.bulletComments.count == 0)
    {
        return nil;
    }
    if (comment) {
        [self.bulletComments removeObjectAtIndex:0];
    }
    return comment;
}
-(void)stop
{
    if (self.bStopAnimation) {
        return;
    }
    self.bStopAnimation = YES;
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView *view = obj;
        [view stopAnimation];
        view = nil;
    }];
    [self.bulletViews removeAllObjects];
}
@end
