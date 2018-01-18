//
//  ABMustLable.m
//  ABCreditApp
//
//  Created by caobo56 on 2017/6/20.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import "ABMustLable.h"

@implementation ABMustLable

-(void)awakeFromNib{
    [super awakeFromNib];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.text];
    if ([self.text hasPrefix:@"*"]) {
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,1)];
    }
    self.attributedText = str;
}



@end
