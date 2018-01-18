//
//  UIView+DDAddition.h
//  IOSDuoduo
//
//  Created by caobo on 14-5-26.
//  Copyright (c) 2014年 caobo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 增加了一些好用的基本属性
 */

@interface UIView (DDAddition)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;


/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 *  subviewWithTag
 *
 *  @param tag view of Tag
 *
 *  @return subviewWithTag
 */
- (id)subviewWithTag:(NSInteger)tag;

/**
 * The view controller whose view contains this view.
 */
- (UIViewController*)viewController;

/**
 给View加上圆角和边框
 */
- (UIView *)roundedCornerAndBorderView;


/**
 *  给View加上圆角
 *
 *  @param roundedCorner CGFloat 的圆角
 */
-(void)roundedCorner:(CGFloat)roundedCorner;


/**
 *  给View加上边框
 *
 *  @param borderWeight CGFloat 的边框
 */
-(void)setBorderWeight:(CGFloat)borderWeight;

/**
 *  给View加上边框颜色
 *
 *  @param borderColor CGFloat 的颜色
 */
-(void)setborderColor:(UIColor*)borderColor;


/**
 阴影透明度

 @param shadowOpacity 阴影透明度
 */
-(void)setShadowOpacity:(CGFloat)shadowOpacity;


/**
 阴影透明度

 @param shadowColor 阴影透明度
 */
-(void)setShadowColor:(UIColor *)shadowColor;


/**
 阴影扩散的范围控制

 @param shadowRadius 阴影扩散的范围控制
 */
-(void)setShadowRadius:(CGFloat)shadowRadius;


/**
 阴影的范围

 @param shadowOffset 阴影的范围
 */
-(void)setShadowOffset:(CGSize)shadowOffset;



/**
 copy

 @return return value description
 */
- (UIView*)copyView;
@end
