//
//  UIViewController+toast.h
//  ARProject
//
//  Created by Simay on 7/10/15.
//  Copyright (c) 2015 Simay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (toast)


/**
 *  toast
 */
- (void)toastMessage:(NSString *)message;
- (void)toastSuccessMessage:(NSString *)message complete:(void(^)(void))complete;
- (void)toastErrorMessage:(NSString *)message complete:(void(^)(void))complete;
- (void)toastMessage:(NSString *)message
               title:(NSString *)title
            duration:(NSTimeInterval)duration
               image:(UIImage *)image
          completion:(void(^)(void))completion;

/**
 *  showLoading
 */
- (void)showLoadingWithMessage:(NSString *)message;
- (void)showLoadingWithMessage:(NSString *)message delay:(NSTimeInterval)delay;
- (void)showLoading:(BOOL)show
              title:(NSString *)title
            details:(NSString *)details
              image:(UIImage *)image;

/**
 *  hideLoading
 */
- (void)hideLodingViewWithSuccessMessage:(NSString *)message;
- (void)hideLodingViewWithErrorMessage:(NSString *)message;
- (void)hideLodingViewWithSuccessMessage:(NSString *)message complete:(void(^)(void))complete;
- (void)hideLodingViewWithErrorMessage:(NSString *)message complete:(void(^)(void))complete;
- (void)hideLodingView;
- (void)hideLodingViewWithTitle:(NSString *)title
                        details:(NSString *)details
                          image:(UIImage *)image
                       duration:(NSTimeInterval)duration
                     completion:(void(^)(void))completion;



@end
