//
//  ViewController.m
//  CommentDemo
//
//  Created by 张真 on 17/3/14.
//  Copyright © 2017年 张真. All rights reserved.
//

#import "ViewController.h"
#import "BulletView.h"
#import "BulletManager.h"
@interface ViewController ()

@property (strong, nonatomic) BulletManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak typeof (self) weakSelf = self;
    self.manager = [[BulletManager alloc]init];
    self.manager.generateViewBlock = ^(BulletView *view){
        [weakSelf addBulletView:view];
    };
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"stop" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(250, 100, 100, 40);
    [btn1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}
- (void)clickBtn
{
    [self.manager start];
}
- (void)clickBtn1
{
    [self.manager stop];
}
- (void)addBulletView:(BulletView *)view
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width, 300 + view.trajectory * 50, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    [self.view addSubview:view];
    [view startAnimation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
