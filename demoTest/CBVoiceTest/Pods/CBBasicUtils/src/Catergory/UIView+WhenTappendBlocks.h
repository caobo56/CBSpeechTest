//
//  UIView+WhenTappendBlocks.h
//  kxe_v2
//
//  Created by caobo56 on 17-12-12.


#import <UIKit/UIKit.h>

typedef void (^JMWhenTappedBlock)(void);

@interface UIView (JMWhenTappedBlocks) <UIGestureRecognizerDelegate>

- (void)whenTapped:(JMWhenTappedBlock)block;
- (void)whenDoubleTapped:(JMWhenTappedBlock)block;
- (void)whenTwoFingerTapped:(JMWhenTappedBlock)block;
- (void)whenTouchedDown:(JMWhenTappedBlock)block;
- (void)whenTouchedUp:(JMWhenTappedBlock)block;

@end


