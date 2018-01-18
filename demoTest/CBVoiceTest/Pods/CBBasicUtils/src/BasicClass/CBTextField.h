//
//  CBTextField.h
//  ABCreditApp
//
//  Created by caobo56 on 2017/3/1.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CBCompletion)(void);

typedef void(^CBdidEditingComp)(UIView * view);
typedef void(^CBdidEditingCompWithOffset)(UIView * view,NSInteger offset);

@interface CBTextField : UITextField


-(void)setCancelBtnComp:(CBCompletion)cancelComp completeBtnComp:(CBCompletion)completeComp didEditingComp:(CBdidEditingComp)didEditingComp title:(NSString *)title;

-(void)setCancelBtnComp:(CBCompletion)cancelComp completeBtnComp:(CBCompletion)completeComp didEditingCompWithOffset:(CBdidEditingCompWithOffset)didEditingComp Offset:(float)offset title:(NSString *)title;


-(void)creatKeyBoardBar;

-(void)setTextlength:(NSInteger)length;

@end
