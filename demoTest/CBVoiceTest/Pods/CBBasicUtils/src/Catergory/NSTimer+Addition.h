//
//  NSTimer+Addition.h
//  ZSCalendar
//
//  Created by caobo56 on 2018/1/12.
//  Copyright © 2018年 caobo56. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSTimer(Addition)

// 暂停
- (void)pause;
// 重新开始
- (void)restart;
// 延迟一定时间启动
- (void)restartAfterTimeInterval:(NSTimeInterval)interval;

@end
