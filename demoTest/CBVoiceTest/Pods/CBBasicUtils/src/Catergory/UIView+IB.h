//
//  UIView+IB.h
//  MeiDouLive
//
//  Created by Puzhi Li on 16/6/5.
//  Copyright © 2016年 Puzhi Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IB)

@property(nonatomic) IBInspectable CGFloat cornerRadius;
@property(nonatomic) IBInspectable CGFloat borderWidth;
@property(nonatomic) IBInspectable UIColor *borderColor;
@property(nonatomic) IBInspectable UIColor *shadowColor;

@property(nonatomic) IBInspectable CGFloat shadowOpacity;// 阴影透明度
@property(nonatomic) IBInspectable CGFloat shadowRadius;// 阴影扩散的范围控制
@property(nonatomic) IBInspectable CGSize shadowOffset;// 阴影的范围


//@property(nonatomic) IBInspectable CGFloat separateLineHeight;
//@property(nonatomic) IBInspectable CGFloat separateLineWidth;

@end
