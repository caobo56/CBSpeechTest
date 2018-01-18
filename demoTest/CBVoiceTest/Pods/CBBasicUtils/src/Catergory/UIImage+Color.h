//
//  UIImage+Color.h
//  MeiDouLivePerformer
//
//  Created by caobo on 16/7/15.
//  Copyright © 2016年 SuperD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIImage(Color) 
/**
 *  生成指定大小的纯色图片
 *
 *  @param color color 大小
 *  @param size  size 大小
 *
 *  @return return image
 */
+ (UIImage*) createImageWithColor: (UIColor*) color andSize:(CGSize)size;

/**
 *  上传图片的时候压缩体积
 *
 *  @return return value description
 */
-(NSData *)resizeForUpload;


/**
 *  重定义尺寸
 *
 *  @return return value description
 */
-(UIImage *)resizeTo:(CGSize)size;

@end
