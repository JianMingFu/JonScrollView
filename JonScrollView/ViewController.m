//
//  ViewController.m
//  JonScrollView
//
//  Created by Jon Fu on 2018/6/26.
//  Copyright © 2018年 Jon Fu. All rights reserved.
//

/*
 
 之前项目用到的侧滑功能，可全自定义，本身已对导航栏跳转和tabbar做了处理，可直接沿用，
 有什么不足的地方还望指正，适用的话请给个小星星O(∩_∩)O谢谢！
 最新demo地址：https://github.com/JianMingFu/JonSlide。
 */


#import "ViewController.h"
#import "JFScrollView.h"
#import "JFHeaderView.h"
#import "JFPageTitleView.h"
#import "JFLeftTableView.h"
#import "JFRightTableView.h"

#define SeparatorHeight 10
@interface ViewController ()<UIScrollViewDelegate, UITableViewDelegate>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) JFPageTitleView *titleView;
@property (nonatomic, strong) JFScrollView *scrollView;
@property (nonatomic, strong) JFLeftTableView *leftTableView;
@property (nonatomic, strong) JFRightTableView *rightTableView;
@property (nonatomic, strong) UILabel *nameLab;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContentView];
    [self setupHeaderView];
    [self setupNavBar];
}

#pragma mark - 导航栏
- (void)setupNavBar {
    
    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopHeight)];
    navBar.backgroundColor = kWhiteColor;
    [self.view addSubview:navBar];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-100)/2.0, kStatusBarHeight+15, 100, 16)];
    titleLab.text = @"客户详情";
    titleLab.textColor = kWordColor1;
    titleLab.font = kBoldFont(16);
    [navBar addSubview:titleLab];
    self.nameLab = titleLab;
}

#pragma mark - 头部
- (void)setupHeaderView {
    
    UIView *headerView = [[JFHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, PageHeaderHeight+PageTitleHeight+SeparatorHeight)];
    headerView.backgroundColor = kBackgroundColor;
    [self.view addSubview:headerView];
    
    JFPageTitleView *titleView = [[JFPageTitleView alloc] initWithFrame:CGRectMake(0, PageHeaderHeight+SeparatorHeight, kScreenWidth, PageTitleHeight)];
    titleView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:titleView];

    self.scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    titleView.titles  = @[@"客户信息", @"信用报告"];
    titleView.selectedIndex = 0;
    titleView.buttonSelected = ^(NSInteger index){
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth * index, 0) animated:YES];
    };
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kSeparatorColor;
    lineView.frame = CGRectMake(kScreenWidth/2.0, 12, 1, 20);
    [titleView addSubview:lineView];
    
    self.titleView = titleView;
    self.headerView = headerView;
}

#pragma mark - 内容
- (void)setupContentView {
    
    JFScrollView *scrollView = [[JFScrollView alloc] init];
    scrollView.delaysContentTouches = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    [self.view addSubview:scrollView];
    
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, 0, PageHeaderHeight+PageTitleHeight+SeparatorHeight);
    
    
    JFLeftTableView *infoTableView = [[JFLeftTableView alloc] initWithFrame:
                                       CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    infoTableView.delegate = self;
    infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    infoTableView.showsVerticalScrollIndicator = NO;
    infoTableView.tableHeaderView = headView;
    infoTableView.backgroundColor = kBackgroundColor;
    infoTableView.estimatedSectionHeaderHeight = 0;
    infoTableView.estimatedSectionFooterHeight = 0;
    [scrollView addSubview:infoTableView];
    
    JFRightTableView *creditTableView = [[JFRightTableView alloc] initWithFrame:
                                           CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    creditTableView.delegate = self;
    creditTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    creditTableView.showsVerticalScrollIndicator = NO;
    creditTableView.tableHeaderView = headView;
    creditTableView.backgroundColor = kBackgroundColor;
    creditTableView.estimatedSectionFooterHeight = 0;
    creditTableView.estimatedSectionHeaderHeight = 0;
    [scrollView addSubview:creditTableView];
    
    
    headView.backgroundColor = kBackgroundColor;
    self.scrollView = scrollView;
    self.leftTableView = infoTableView;
    self.rightTableView = creditTableView;
    
    if (@available(iOS 11.0, *)) {
        self.leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.rightTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == self.scrollView) {
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        NSInteger pageNum = contentOffsetX / kScreenWidth + 0.5;
        self.titleView.selectedIndex = pageNum;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.leftTableView || scrollView == self.rightTableView) {
        CGFloat offY = scrollView.contentOffset.y;
        if (offY < 0) {
            scrollView.contentOffset = CGPointZero;
        }
    }
    
    if (scrollView == self.scrollView || !scrollView.window) {
        return;
    }
    CGFloat offsetY      = scrollView.contentOffset.y;
    CGFloat originY      = 0;
    CGFloat otherOffsetY = 0;
    if (offsetY <= PageHeaderHeight-kTopHeight+SeparatorHeight) {
        originY = -offsetY;
        if (offsetY == 0) {
            otherOffsetY = 0;
            self.nameLab.text = @"客户详情";
        } else {
            otherOffsetY = offsetY;
            self.nameLab.text = @"召唤师";
        }
        
    } else {
        originY   = -PageHeaderHeight+kTopHeight-SeparatorHeight;
        otherOffsetY  = PageHeaderHeight;
        self.nameLab.text = @"召唤师";
    }
    self.headerView.frame = CGRectMake(0, originY, kScreenWidth, PageHeaderHeight+PageTitleHeight+SeparatorHeight);
    //    NSLog(@"%f", originY);
    //    NSLog(@"---%f", offsetY);
    for ( int i = 0; i < self.titleView.titles.count; i++ ) {
        if (i != self.titleView.selectedIndex) {
            UITableView *contentView = self.scrollView.subviews[i];
            CGPoint offset = CGPointMake(0, otherOffsetY);
            if ([contentView isKindOfClass:[UITableView class]]) {
                if (contentView.contentOffset.y < PageHeaderHeight || offset.y < PageHeaderHeight) {
                    [contentView setContentOffset:offset animated:NO];
                    self.scrollView.offset = offset;
                }
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
