//
//  UIBarButtonItem+Extension.h
//  ZSCalendar
//
//  Created by caobo56 on 2017/12/18.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  导航item的扩展
 */
@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image highImage:(UIImage *)highImage;

@end
