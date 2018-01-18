//
//  NSTimer+Addition.m
//  ZSCalendar
//
//  Created by caobo56 on 2018/1/12.
//  Copyright © 2018年 caobo56. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer(Addition)


- (void)pause{
    
    if ([self isValid]) {
        [self setFireDate:[NSDate distantFuture]];
    }
}

- (void)restart{
    
    if ([self isValid]) {
        [self setFireDate:[NSDate date]];
    }
}

- (void)restartAfterTimeInterval:(NSTimeInterval)interval{
    
    if ([self isValid]) {
        [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
    }
}

@end
