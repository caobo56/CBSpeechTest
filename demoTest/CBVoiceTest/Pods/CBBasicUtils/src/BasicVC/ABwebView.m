//
//  ABwebView.m
//  ABCreditApp
//
//  Created by caobo56 on 2017/7/25.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import "ABwebView.h"

@interface ABwebView ()

@end

@implementation ABwebView

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [[NSURL alloc]initWithString:self.url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
