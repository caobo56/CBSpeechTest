//
//  LvInputView.m
//  QMB
//
//  Created by LC_MAC-1 on 14-8-28.
//  Copyright (c) 2014年 MLJ. All rights reserved.
//

#import "LvInputView.h"

@implementation LvInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(LvInputView *)creatInputView
{
  return [[[NSBundle mainBundle]loadNibNamed:@"LvInputView" owner:nil options:nil]lastObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
