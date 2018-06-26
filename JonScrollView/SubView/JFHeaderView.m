//
//  JFHeaderView.m
//  JonScrollView
//
//  Created by Jon Fu on 2018/6/26.
//  Copyright © 2018年 Jon Fu. All rights reserved.
//

#import "JFHeaderView.h"

@implementation JFHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIButton *headBtn = [UIButton new];
        [headBtn setImage:[UIImage imageNamed:@"slide_head"] forState:UIControlStateNormal];
        headBtn.clipsToBounds = YES;
        headBtn.layer.cornerRadius = 20;
        headBtn.frame = CGRectMake(20, (frame.size.height-40)/2, 40, 40);
        [self addSubview:headBtn];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headBtn.frame), CGRectGetMinY(headBtn.frame)+16, 80, 16)];
        nameLab.text = @"Jon Fu";
        nameLab.textColor = kMainColor;
        nameLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:nameLab];
        
        UILabel *signatureLab = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(headBtn.frame)+20, 200, 16)];
        signatureLab.text = @"你是我一生都不愿修复的Bug";
        signatureLab.textColor = kMainColor;
        signatureLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:signatureLab];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
