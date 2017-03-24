//
//  ViewController.m
//  Progress_Pro
//
//  Created by mac on 17/3/23.
//  Copyright © 2017年 _. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"
#import "UIColor+Hex.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CircleView *_circle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _circle = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _circle.center = self.view.center;
    _circle.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithHex:0x33b8f4 alpha:1.0];
    [self.view addSubview:_circle];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    slider.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 50);
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;
    slider.value = 1.0;
    slider.minimumTrackTintColor = [UIColor colorWithHex:0xdc5496 alpha:1.0];
    slider.maximumTrackTintColor = [UIColor whiteColor];
    [slider addTarget:self action:@selector(slide:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

- (void)slide:(UISlider *)slide {
    [_circle setProgress:slide.value];
}
@end
