//
//  ViewController.m
//  CustomSegment
//
//  Created by 朱松泽 on 2018/7/12.
//  Copyright © 2018年 朱松泽. All rights reserved.
//

#import "ViewController.h"
#import "CustomSegment.h"
#import "FirstVC.h"
#import "SecondVC.h"
#import "ThirdVC.h"
#import "FourthVC.h"
/**
 * 通用导航条和tabbar高度
 */
//状态栏高度
#define DLC_StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航条高度
#define DLC_NavBarHeight 44.0
//整个导航栏高度
#define kNavigationHeight (DLC_StatusBarHeight + DLC_NavBarHeight)


#define SegmentHeight 44
@interface ViewController ()<UIScrollViewDelegate>
/** <#注释#> */
@property (nonatomic, strong) CustomSegment *segment;
/** <#注释#> */
@property (nonatomic, strong) UIScrollView *scrollView;
/** <#注释#> */
@property (nonatomic, strong) NSMutableArray *controllers;
@end

@implementation ViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"CustomSegment";
    [self pri_setChildVCViewToScrollView];
    [self pri_setUpChildView];
    [self pri_setDefalutLayout];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - public methods


#pragma mark - private methods 添加 pri_ 前缀
- (void)pri_setUpChildView {
    [self.view addSubview:self.segment];
    [self.view addSubview:self.scrollView];
}

- (void)pri_setDefalutLayout {
    
}

- (void)pri_setChildVCViewToScrollView {
    
    FirstVC *firstVC = [[FirstVC alloc] init];
    SecondVC *secondVC = [[SecondVC alloc] init];
    ThirdVC *thirdVC = [[ThirdVC alloc] init];
    FourthVC *fourthVC = [[FourthVC alloc] init];
    
    [self.controllers addObject:firstVC];
    [self.controllers addObject:secondVC];
    [self.controllers addObject:thirdVC];
    [self.controllers addObject:fourthVC];
    
    [self.controllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = (UIViewController *)obj;
        [self.scrollView addSubview:vc.view];
        vc.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*idx, 0, CGRectGetWidth(self.scrollView.frame), [UIScreen mainScreen].bounds.size.height-kNavigationHeight-SegmentHeight);
        [self addChildViewController:vc];
    }];
    
    
}

#pragma mark - delegate
#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    self.segment.currentIndex = offset.x/CGRectGetWidth(self.view.frame);
}
#pragma mark - tableViewDelegate

#pragma mark - event response


#pragma mark - lazy loading

- (CustomSegment *)segment {
    if (!_segment) {
        
        _segment = [[CustomSegment alloc] initWithFrame:CGRectMake(0, kNavigationHeight, CGRectGetWidth(self.view.frame), SegmentHeight) titleArray:@[@"标题1",@"标题2",@"标题3",@"标题4"] actionBlock:^(NSString *currentTitle, NSArray *itemTitleArray) {
            __weak __typeof(self) weakSelf = self;
            [itemTitleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *tempTitle = (NSString *)obj;
                if ([currentTitle isEqualToString:tempTitle]) {
                    CGFloat offsetX = CGRectGetWidth(self.view.frame) * idx;
                    weakSelf.scrollView.contentOffset = CGPointMake(offsetX, 0);
                    *stop = YES;
                }
            }];
        }];
        _segment.bottomLineColor = [UIColor cyanColor];
        _segment.cursorLineColor = [UIColor redColor];
        _segment.cursorLineWidth = 30;// 默认均分
    }
    return _segment;
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SegmentHeight+kNavigationHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-SegmentHeight)];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * 4, CGRectGetHeight(_scrollView.frame));
        _scrollView.bounces = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (NSMutableArray *)controllers {
    if (!_controllers) {
        
        _controllers = [[NSMutableArray alloc] init];
    }
    return _controllers;
}
@end
