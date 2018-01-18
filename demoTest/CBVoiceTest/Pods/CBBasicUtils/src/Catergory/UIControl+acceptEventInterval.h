//
//  UIControl.h
//  triprice
//
//  Created by caobo56 on 16/3/7.
//
//

/**
 *用runtime 解决UIButton 重复点击问题
 */

#import <UIKit/UIKit.h>


@interface UIControl (acceptEventInterval)


@property (nonatomic, assign) NSTimeInterval hyn_acceptEventInterval;//添加点击事件的间隔事件

@property (nonatomic, assign) BOOL hyn_ignoreEvent;//上一个action是否执行完毕 YES完事NO没有执行完毕

@end
