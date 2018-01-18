//
//  UIBarButtonItem+Extension.m
//  ZSCalendar
//
//  Created by caobo56 on 2017/12/18.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+DDAddition.h"

@implementation UIBarButtonItem (Extension)

/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image highImage:(UIImage *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
        btn.size = image.size;
    }else{
        btn.size = CGSizeMake(44, 44);
    }
    
    if (highImage) {
        [btn setImage:highImage forState:UIControlStateHighlighted];
    }

    // 设置尺寸

    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
