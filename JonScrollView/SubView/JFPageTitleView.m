//
//  JFPageTitleView.m
//  JonScrollView
//
//  Created by Jon Fu on 2018/6/26.
//  Copyright © 2018年 Jon Fu. All rights reserved.
//

#import "JFPageTitleView.h"

@interface JFPageTitleView ()
@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, weak) UIButton *selectedButton;
@end

@implementation JFPageTitleView


- (void)titleButtonClicked:(UIButton *)button {
    _selectedIndex = button.tag;
    if (self.selectedButton) {
        self.selectedButton.selected = YES;
    }
    button.selected = NO;
    self.selectedButton = button;
    
    if (self.buttonSelected) {
        self.buttonSelected(button.tag);
    }
    
    NSString* title = self.titles[button.tag];
    CGFloat sliderWidth = button.titleLabel.font.pointSize * title.length;
    self.sliderView.centerX = button.centerX;
//    [self.sliderView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(sliderWidth);
//        make.height.mas_equalTo(2);
//        make.centerX.equalTo(button);
//        make.bottom.equalTo(self).offset(-2);
//    }];
//    [UIView animateWithDuration:0.25 animations:^{
//        [self layoutIfNeeded];
//    }];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex   = selectedIndex;
    UIButton* button = self.subviews[selectedIndex];
    [self titleButtonClicked:button];
}

- (void)setTitles:(NSArray *)titles {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _titles = titles;
    CGFloat width = [UIScreen mainScreen].bounds.size.width / titles.count;
    
    for ( int i = 0; i<titles.count; i++ ) {
        UIButton* titleButton = [self titleButton:titles[i]];
        titleButton.tag = i;
        titleButton.frame = CGRectMake(width * i, 0, width, self.frame.size.height);
        [self addSubview:titleButton];
//        [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.equalTo(self);
//            make.left.equalTo(self).offset(width * i);
//            make.width.mas_equalTo(width);
//        }];
        if (i != 0) {
            titleButton.selected  = YES;
        } else {
            self.selectedButton = titleButton;
        }
    }
    UIButton *button = self.subviews[0];
    NSString *title  = titles[0];
    CGFloat sliderWidth = button.titleLabel.font.pointSize * title.length;
    self.sliderView.frame = CGRectMake(CGRectGetMinX(button.titleLabel.frame), CGRectGetMaxY(button.frame), sliderWidth, 4);
    [self addSubview:self.sliderView];
//    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(sliderWidth);
//        make.height.mas_equalTo(4);
//        make.centerX.equalTo(button);
//        make.bottom.equalTo(self).offset(-3);
//    }];
//    [self layoutIfNeeded];
}

- (UIButton *)titleButton:(NSString *)title {
    UIButton* titleButton = [[UIButton alloc] init];
    [titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.titleLabel.font = kBoldFont(16);
    [titleButton setTitleColor:kWordColor1 forState:UIControlStateNormal];
    //[titleButton setTitleColor:kWordColor1 forState:UIControlStateSelected];
    [titleButton setTitle:title forState:UIControlStateNormal];
    return titleButton;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        UIView* sliderView = [[UIView alloc] init];
        sliderView.backgroundColor = kMainColor;
        sliderView.layer.cornerRadius = 2;
        sliderView.clipsToBounds  = YES;
        _sliderView  = sliderView;
    }
    return _sliderView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
