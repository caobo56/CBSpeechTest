//
//  LvInputView.h
//  QMB
//
//  Created by LC_MAC-1 on 14-8-28.
//  Copyright (c) 2014年 MLJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LvInputView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
+(LvInputView *)creatInputView;
@end
