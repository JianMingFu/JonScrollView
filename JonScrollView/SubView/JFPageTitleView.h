//
//  JFPageTitleView.h
//  JonScrollView
//
//  Created by Jon Fu on 2018/6/26.
//  Copyright © 2018年 Jon Fu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PageTitleHeight 44
@interface JFPageTitleView : UIView

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) void (^buttonSelected)(NSInteger index);
@end
