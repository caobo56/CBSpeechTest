//
//  UIViewController+toast.m
//  ARProject
//
//  Created by Simay on 7/10/15.
//  Copyright (c) 2015 Simay. All rights reserved.
//

#import "UIView+toast.h"
#import <objc/runtime.h>
#import "MBProgressHUD.h"

#define RGBAlpha(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

static char HUDKey;
static const NSTimeInterval kDuration = 1.5;
static const float kDetailTitleFont = 15;
static const float kMargin = 15;


@implementation UIView (toast)

- (MBProgressHUD *)HUDView
{
    MBProgressHUD *HUD = objc_getAssociatedObject(self, &HUDKey);
    if (!HUD)
    {
        HUD = [[MBProgressHUD alloc] initWithView:self];
        HUD.removeFromSuperViewOnHide = YES;
        HUD.detailsLabel.font = [UIFont systemFontOfSize:kDetailTitleFont];
        HUD.margin = kMargin;
        objc_setAssociatedObject(self, &HUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return HUD;
}

- (void)toastSuccessMessage:(NSString *)message
{    
    [self toastSuccessMessage:message complete:NULL];
}

- (void)toastSuccessMessage:(NSString *)message complete:(void (^)(void))complete
{
    UIImage *image = [[UIImage imageNamed:@"cb_success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self toastMessage:message title:nil duration:kDuration image:image completion:complete];
}

- (void)toastErrorMessage:(NSString *)message complete:(void (^)(void))complete
{
    UIImage *image = [[UIImage imageNamed:@"cb_error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self toastMessage:message title:nil duration:kDuration image:image completion:complete];
}

- (void)toastMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.color = RGBAlpha(0x000000, 0.8);
    hud.bezelView.alpha = 0.8;
    hud.detailsLabel.text = message;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    hud.margin = 15.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:NO afterDelay:1.5];
}

- (void)showLoadingWithMessage:(NSString *)message
{

    [self showLoading:YES title:message details:nil image:nil];

}

- (void)showLoadingWithMessage:(NSString *)message delay:(NSTimeInterval)delay
{
    [self addSubview:self.HUDView];
    self.HUDView.label.text = message;
    [self.HUDView showAnimated:NO];
    [self.HUDView hideAnimated:NO afterDelay:delay];
    
}

- (void)hideLodingView
{
    [self.HUDView hideAnimated:NO];
    objc_setAssociatedObject(self, &HUDKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hideLodingViewWithErrorMessage:(NSString *)message
{
    [self hideLodingViewWithErrorMessage:message complete:NULL];
}

- (void)hideLodingViewWithSuccessMessage:(NSString *)message
{
    [self hideLodingViewWithSuccessMessage:message complete:NULL];
}

- (void)hideLodingViewWithSuccessMessage:(NSString *)message complete:(void (^)(void))complete
{
    UIImage *image = [[UIImage imageNamed:@"cb_success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self hideLodingViewWithTitle:message details:nil image:image duration:kDuration completion:complete];
}

- (void)hideLodingViewWithErrorMessage:(NSString *)message complete:(void (^)(void))complete{
    UIImage *image = [[UIImage imageNamed:@"cb_error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self hideLodingViewWithTitle:message details:nil image:image duration:kDuration completion:complete];
}

- (void)toastMessage:(NSString *)message
            title:(NSString *)title
            duration:(NSTimeInterval)duration
            image:(UIImage *)image
          completion:(void(^)(void))completion {
    [self showLoading:NO title:title details:message image:image];
    [self hideLodingViewWithTitle:title details:message image:image duration:kDuration completion:completion];
}


- (void)showLoading:(BOOL)show
              title:(NSString *)title
             details:(NSString *)details
               image:(UIImage *)image {

    if (show) {
        self.HUDView.mode = MBProgressHUDModeIndeterminate;
    }
    else {
        self.HUDView.mode = MBProgressHUDModeText;
    }
    [self addSubview:self.HUDView];
    self.HUDView.label.text = title;
    self.HUDView.detailsLabel.text = details;
    [self.HUDView showAnimated:NO];
    
}
- (void)hideLodingViewWithTitle:(NSString *)title
                          details:(NSString *)details
                            image:(UIImage *)image
                         duration:(NSTimeInterval)duration
                       completion:(void(^)(void))completion {
    
    if (image) {
        self.HUDView.mode = MBProgressHUDModeCustomView;
        self.HUDView.customView = [[UIImageView alloc] initWithImage:image];
    }
    self.HUDView.detailsLabel.text = details;
    self.HUDView.label.text = title;
    
    [self.HUDView hideAnimated:NO afterDelay:duration];
    self.HUDView.completionBlock = ^ {
        if (completion) {
            completion();
        }
        objc_setAssociatedObject(self, &HUDKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    };
}


@end
