//
//  CircleView.m
//  Progress_Pro
//
//  Created by mac on 17/3/23.
//  Copyright © 2017年 _. All rights reserved.
//

#import "CircleView.h"
#import <CoreGraphics/CoreGraphics.h>
#import "UIColor+Hex.h"

@interface CircleView ()

@property (nonatomic, assign) CGFloat currentValue;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) CAReplicatorLayer *ReplicatorLayer;
@end

@implementation CircleView

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatLittleCircleWithCount:18 alpha:1.0 color:[UIColor whiteColor] duration:1.0 replicatorLayer:self.ReplicatorLayer];
        [self creatLittleCircleWithCount:36 alpha:0.6 color:[UIColor whiteColor] duration:1.0 replicatorLayer:self.ReplicatorLayer];
        self.currentValue = 0.999999999;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    CGFloat centerX = width / 2.0;
    CGFloat centerY = height / 2.0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //=============大圆
    CGContextBeginPath(context);
    //设置画笔颜色
    CGContextSetRGBStrokeColor(context, 1.0f, 1.0f, 1.0f, 1.0);
    //设置线条宽度
    CGContextSetLineWidth(context, 4.0f);
    //设置线条端点形状
    CGContextSetLineCap(context, kCGLineCapRound);
    //获得路径
    CGMutablePathRef pathOutside = CGPathCreateMutable();
    //设置路径形状
    CGPathAddArc(pathOutside, NULL, centerX, centerY, width / 2.0f - 2.0, M_PI_2 * 3, M_PI * 2 *_currentValue - M_PI_2, NO);
    //画布添加路径
    CGContextAddPath(context, pathOutside);
    //开始描绘
    CGContextStrokePath(context);
    
    //==============小圆
    CGContextBeginPath(context);
    //设置画笔颜色
    CGContextSetRGBStrokeColor(context, 1.0f, 1.0f, 1.0f, 1.0);
    //设置线条宽度
    CGContextSetLineWidth(context, 1.0f);
    //设置线条端点形状
    CGContextSetLineCap(context, kCGLineCapRound);
    //获得路径
    CGMutablePathRef pathInside = CGPathCreateMutable();
    //设置路径形状
    CGPathAddArc(pathInside, NULL, centerX, centerY, width / 2.0f - 10, M_PI_2 * 3, M_PI * 2 *_currentValue - M_PI_2, NO);
    //画布添加路径
    CGContextAddPath(context, pathInside);
    //开始描绘
    CGContextStrokePath(context);
    
    //中间圆
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerX) radius:_currentValue * (width / 2.0f - 15) startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    [[[UIColor whiteColor] colorWithAlphaComponent:0.2] set];
    [circlePath closePath];
    [circlePath fill];
    
    //中间文字
    NSString *showString = [[NSString stringWithFormat:@"%.2f",_currentValue * 100] stringByAppendingString:@"%"];
//    CGSize size = [showString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(1000, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize size = [showString boundingRectWithSize:CGSizeMake(1000, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30.0]} context:nil].size;
    CGFloat wordWidth = size.width;
    CGFloat wordHeight = size.height;
    [[UIColor whiteColor] set];
    CGRect wordRect = CGRectMake((width - wordWidth) / 2, (height - wordHeight) / 2, wordWidth, wordHeight);
    [showString drawInRect:wordRect withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:30.0]}];
}

#pragma mark - setter
- (void)setCurrentValue:(CGFloat)currentValue {
    _currentValue = currentValue;
    [self setNeedsDisplay];
}

#pragma mark - Private
- (void)creatLittleCircleWithCount:(NSInteger)count
                             alpha:(CGFloat)alpha
                             color:(UIColor *)color
                          duration:(CGFloat)duration
                   replicatorLayer:(CAReplicatorLayer *)layer {
    layer = [CAReplicatorLayer layer];
    layer.frame = self.bounds;
    layer.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layer];
    CALayer *circleLayer = [CALayer layer];
    circleLayer.frame = CGRectMake(0, 0, 4.0, 4.0);
    circleLayer.position = CGPointMake(CGRectGetWidth(self.frame) * 0.5 - 2.0, 2.0);
    circleLayer.cornerRadius = 2.0;
    circleLayer.backgroundColor = [color colorWithAlphaComponent:alpha].CGColor;
    [layer addSublayer:circleLayer];
    
    layer.instanceCount = count;
    layer.instanceTransform = CATransform3DMakeRotation(M_PI * 2 / count, 0, 0, 1);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @1.1f;
    animation.toValue = @0.6f;
    animation.duration = duration;
    animation.repeatCount = HUGE;
    animation.autoreverses = YES;
    [circleLayer addAnimation:animation forKey:nil];
}

#pragma mark - Public
- (void)setProgress:(CGFloat)progress {
    if (progress == 1.0000000) {
        progress = progress - 0.000001;
    }
    self.currentValue = progress;
}
@end
