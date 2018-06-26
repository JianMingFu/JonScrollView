//
//  JFScrollView.h
//  JonScrollView
//
//  Created by Jon Fu on 2018/6/26.
//  Copyright © 2018年 Jon Fu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PageHeaderHeight (kStatusBarHeight+180)
@interface JFScrollView : UIScrollView
@property (nonatomic, assign) CGPoint offset;
@end
