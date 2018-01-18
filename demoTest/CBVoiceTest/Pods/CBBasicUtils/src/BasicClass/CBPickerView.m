//
//  CBPickerView.m
//  ZSCalendar
//
//  Created by caobo56 on 2017/12/19.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import "CBPickerView.h"
#import "LvInputView.h"
#import "Masonry.h"

#define SCREEN_HEIGHTL [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTHL [UIScreen mainScreen].bounds.size.width
#define RGBAlpha(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

@interface CBPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)LvInputView * headView;

@property(nonatomic,strong)UIPickerView * pickerView;

@property(nonatomic,strong)NSArray * dataArr;

@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)id selectData;

@end

@implementation CBPickerView

- (instancetype)initWithDateArr:(NSArray *)arr
{
    self = [super init];
    if (self) {
        _dataArr = arr;
        [self addSubview];
    }
    return self;
}

-(void)addSubview{
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTHL, SCREEN_HEIGHTL)];
    self.backgroundColor = RGBAlpha(0x000000, 0.5);
    
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHTL-216, SCREEN_WIDTHL, 216)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pickerView];
    
    _headView = [LvInputView creatInputView];
    _headView.backgroundColor = [UIColor whiteColor];
    _headView.titlelabel.text = @"请选择";
    [self addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.pickerView.mas_top);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(44);
    }];
    [_headView.cancelBtn addTarget:self action:@selector(cancelBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headView.completeBtn addTarget:self action:@selector(completeBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * touchView = [[UIView alloc]init];
    [self addSubview:touchView];
    [touchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self.headView.mas_top);
    }];
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [touchView addGestureRecognizer:singleTap];
}

-(void)cancelBtnPress:(id)sender{
    self.hidden = YES;
    [self removeFromSuperview];
}

-(void)completeBtnPress:(id)sender{
    if (!_selectData) {
        _selectData = _dataArr[_index];
    }
    [self.delegate pickerViewdidSetectWith:self Data:_selectData andIndex:_index];
    self.hidden = YES;
    [self removeFromSuperview];
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    self.hidden = YES;
    [self removeFromSuperview];
}

-(void)setDefaultIndex:(NSInteger)index{
    if (index <= _dataArr.count-1) {
        _index = index;
        [_pickerView selectRow:index inComponent:0 animated:YES];
    }else{
        NSLog(@"指定位置超出数组边界");
    }
}


#pragma UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArr.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_dataArr objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    _selectData = _dataArr[row];
    _index = row;
}

@end

