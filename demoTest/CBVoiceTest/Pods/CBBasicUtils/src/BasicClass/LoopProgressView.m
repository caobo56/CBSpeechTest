//
//  LoopProgressView.m
//  环形进度条
//
//  Created by caobo56 on 2018/1/8.
//  Copyright © 2018年 caobo56. All rights reserved.
//

#import "LoopProgressView.h"
#import <QuartzCore/QuartzCore.h>

#define ViewWidth self.frame.size.width   //环形进度条的视图宽度
#define ProgressWidth 4                   //环形进度条的圆环宽度
#define Radius ViewWidth/2-ProgressWidth  //环形进度条的半径

#define RGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@interface LoopProgressView()<CAAnimationDelegate>

@property (nonatomic, assign) CGFloat speed;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, strong)  CAShapeLayer *arcLayer;

@end

@implementation LoopProgressView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.strokeColor = RGB16(0xE60012);
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef progressContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(progressContext, ProgressWidth);
    CGContextSetRGBStrokeColor(progressContext, 255.0, 255.0, 255.0, 0.8);
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    
    //绘制环形进度条底框
    CGContextAddArc(progressContext, xCenter, yCenter, Radius, 0, 2*M_PI, 0);
    CGContextDrawPath(progressContext, kCGPathStroke);
    
    //    //绘制环形进度环
    CGFloat to = - M_PI * 0.5 + self.progress * M_PI *2; // - M_PI * 0.5为改变初始位置
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(xCenter,yCenter) radius:Radius startAngle:- M_PI * 0.5 endAngle:to clockwise:YES];
    CAShapeLayer * arcLayer=[CAShapeLayer layer];
    arcLayer.path=path.CGPath;//46,169,230
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.strokeColor = _strokeColor.CGColor;
    arcLayer.lineWidth=ProgressWidth;
    arcLayer.lineCap = @"round";
    if (_arcLayer) {
        [self.layer replaceSublayer:_arcLayer with:arcLayer];
    }else{
        [self.layer addSublayer:arcLayer];
    }
    _arcLayer = arcLayer;
}


-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    if (self.progress > 1) {
//        NSLog(@"传入数值范围为 0-1");
        self.progress = 1;
    }else if (self.progress < 0){
//        NSLog(@"传入数值范围为 0-1");
        self.progress = 0;
    }
    [self setNeedsDisplay];
}

-(void)startAnimationAddWithTimeInterval:(float)interval{
    _speed = (1 - _progress)/(interval*100);
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(startAddAnimation) userInfo:nil repeats:YES];
}

-(void)startAnimationDecreaseWithTimeInterval:(float)interval{
    _speed = _progress/(interval*100);
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(startDecreaseAnimation) userInfo:nil repeats:YES];
}

-(void)startAddAnimation{
    _progress = _progress + _speed;
    if (_progress < 0 || _progress > 1) {
        [_timer invalidate];
        _timer = nil;
    }else{
        [_delegate loopProgressWithView:self withProgress:_progress withAnimaType:AnimaTypeAdd];
        [self setNeedsDisplay];
    }
}

-(void)startDecreaseAnimation{
    _progress = _progress - _speed;
    if (_progress < 0 || _progress > 1) {
        [_timer invalidate];
        _timer = nil;
    }else{
        [_delegate loopProgressWithView:self withProgress:_progress withAnimaType:AnimaTypeDec];
        [self setNeedsDisplay];
    }
}
@end
