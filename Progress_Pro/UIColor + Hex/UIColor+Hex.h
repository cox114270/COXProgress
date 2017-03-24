//
//  UIColor+Hex.h
//  doWhat
//
//  Created by mac on 17/3/20.
//  Copyright © 2017年 _. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

@end
