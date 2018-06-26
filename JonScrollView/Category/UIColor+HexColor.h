//
//  UIColor+HexColor.h
//  FudgeClockApp
//
//  Created by 浩GG on 2016/10/29.
//  Copyright © 2016年 Peng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor*)getMostColorWithImage:(UIImage *)image;

@end
