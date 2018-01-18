//
//  UIImage+Color.m
//  MeiDouLivePerformer
//
//  Created by caobo on 16/7/15.
//  Copyright © 2016年 SuperD. All rights reserved.
//

#import "UIImage+Color.h"

@implementation  UIImage(Color) 

+ (UIImage*) createImageWithColor: (UIColor*) color andSize:(CGSize)size
{
    CGRect rect=CGRectMake(0,0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(NSData *)resizeForUpload{
    if (!self) {
        return nil;
    }
    NSData* data;
    for (float i = 1.0; i >= 0.1; i = i-0.1) {
        data = UIImageJPEGRepresentation(self, i);
        if (data.length < 1048576 ) {//1兆字节(mb)=1048576字节(b)
            break;
        }
    }
    if (data == nil) {
        return nil;
    }
    return data;
}


-(UIImage *)resizeTo:(CGSize)size{
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

@end
