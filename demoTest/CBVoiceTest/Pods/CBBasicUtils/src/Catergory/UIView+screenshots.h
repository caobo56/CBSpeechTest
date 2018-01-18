//
//  UIView+screenshots.h
//  jingduoduo
//
//  Created by diaojz on 16/3/31.
//  Copyright © 2016年 totem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (screenshots)

/**
 *  获取全屏截图
 */
- (UIImage *)p_getFullScreenshots;


- (UIImage *)p_getScreenshotsSubView:(UIView *)view;


@end
