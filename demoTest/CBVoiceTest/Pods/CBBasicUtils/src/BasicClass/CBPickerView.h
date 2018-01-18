//
//  CBPickerView.h
//  ZSCalendar
//
//  Created by caobo56 on 2017/12/19.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBPickerView;

@protocol PickerDelegate
@optional


/**
 代理方法

 @param pickerView 返回自身
 @param data 返回选中的数据
 @param index 返回选中的index
 */
-(void)pickerViewdidSetectWith:(CBPickerView *)pickerView Data:(id)data andIndex:(NSInteger)index;

@end

@interface CBPickerView : UIView

@property(nonatomic,weak) id<PickerDelegate> delegate;


/**
 构造方法

 @param arr 选择的数组，string数组的形式
 @return CBPickerView对象
 */
-(instancetype)initWithDateArr:(NSArray <NSString*>*)arr;


/**
 设置默认数据

 @param index 位置
 */
-(void)setDefaultIndex:(NSInteger)index;

@end
