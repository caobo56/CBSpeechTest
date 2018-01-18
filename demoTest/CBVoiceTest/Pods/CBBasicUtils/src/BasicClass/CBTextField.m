//
//  CBTextField.m
//  ABCreditApp
//
//  Created by caobo56 on 2017/3/1.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import "CBTextField.h"
#import "LvInputView.h"

@interface CBTextField()

@property (nonatomic,copy)CBdidEditingComp didEditingComp;
@property (nonatomic,copy)CBdidEditingCompWithOffset didEditingCompWithOffset;
@property (nonatomic,assign)float offset;
@property (nonatomic,copy)CBCompletion cancelComp;
@property (nonatomic,copy)CBCompletion completeComp;
@property (nonatomic,copy)NSString * lvTitle;

@property (nonatomic,assign)NSInteger length;

@end

@implementation CBTextField

-(void)awakeFromNib{
    [super awakeFromNib];
    [self creatKeyBoardBar];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatKeyBoardBar];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setTextlength:(NSInteger)length{
    _length = length;
}

-(void)creatKeyBoardBar{
    LvInputView *view = [LvInputView creatInputView];
    view.titlelabel.text = _lvTitle;
    [view.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [view.completeBtn addTarget:self action:@selector(completeBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.inputAccessoryView = view;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChange:) name:UITextFieldTextDidChangeNotification object:self];
    _length = 30;
}


-(void)setCancelBtnComp:(CBCompletion)cancelComp completeBtnComp:(CBCompletion)completeComp didEditingComp:(CBdidEditingComp)didEditingComp title:(NSString *)title{
    _didEditingComp = didEditingComp;
    _cancelComp = cancelComp;
    _completeComp = completeComp;
    _lvTitle = title;
}

-(void)setCancelBtnComp:(CBCompletion)cancelComp completeBtnComp:(CBCompletion)completeComp didEditingCompWithOffset:(CBdidEditingCompWithOffset)didEditingComp Offset:(float)offset title:(NSString *)title{
    _didEditingCompWithOffset = didEditingComp;
    _offset = offset;
    _cancelComp = cancelComp;
    _completeComp = completeComp;
    _lvTitle = title;
}


- (void)cancelBtnClick:(UIButton *)btn
{
    [self.superview endEditing:YES];
    if (_completeComp) {
        _cancelComp();
    }
}
- (void)completeBtnClick:(UIButton *)btn
{
    [self.superview endEditing:YES];
    if (_completeComp) {
        _completeComp();
    }
}

-(void)didBeginEditing:(id)sender{
    if (_didEditingComp) {
        _didEditingComp(self);
    }
    
    if (_didEditingCompWithOffset) {
        _didEditingCompWithOffset(self,_offset);
    }
}

-(void)didChange:(id)sender{
    if (_length > 0) {
        if (self.text.length > _length) {
            self.text = [self.text substringToIndex:_length];
        }
    }
}

@end
