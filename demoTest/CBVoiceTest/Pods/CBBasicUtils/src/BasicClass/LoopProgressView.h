//
//  LoopProgressView.h
//  环形进度条
//
//  Created by caobo56 on 2018/1/8.
//  Copyright © 2018年 caobo56. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum AnimationType {
    AnimaTypeDefault = 0,
    AnimaTypeAdd,
    AnimaTypeDec
} AnimationType;

@class LoopProgressView;
@protocol LoopProgressDelegate
@optional

/**
 圆形进度条代理

 @param view 当前LoopProgressView对象
 @param progress 当前进度
 @param type 当前递增还是递减
 */
-(void)loopProgressWithView:(LoopProgressView *)view
               withProgress:(float)progress
              withAnimaType:(AnimationType)type;

@end


/**
 环形进度条
 */
@interface LoopProgressView : UIView

@property (nonatomic, assign) CGFloat progress;
//设置初始进度（0~1.00）

@property (nonatomic, strong) UIColor * strokeColor;
//设置圆形进度条颜色

@property(nonatomic,weak) id<LoopProgressDelegate> delegate;
//设置圆形进度条代理

/**
 设置圆形进度条进度时长，并开始自动递增的动画

 @param interval 从interval 递增到 1.00 的时长
 */
-(void)startAnimationAddWithTimeInterval:(float)interval;

/**
 设置圆形进度条进度时长，并开始自动递减的动画
 
 @param interval 从interval 递减到 0.00 的时长
 */
-(void)startAnimationDecreaseWithTimeInterval:(float)interval;


@end

