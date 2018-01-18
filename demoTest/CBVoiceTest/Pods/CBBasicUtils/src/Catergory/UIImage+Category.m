//
//  UIImage+Category.m
//  live
//
//  Created by kenneth on 15-7-9.
//  Copyright (c) 2015年 kenneth. All rights reserved.
//

#import "UIImage+Category.h"

static const int kMaxLevel = 60;

@implementation UIImage (Category)
static NSMutableArray *sLavelImageArray;

+ (void)initialize
{
    sLavelImageArray = [[NSMutableArray alloc] initWithCapacity:kMaxLevel];
    
    for (int i = 0; i < kMaxLevel; ++i)
    {
        [sLavelImageArray addObject:[NSNull null]];
    }
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGRect fillRect = CGRectMake(0, 0, size.width, size.height);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextFillRect(currentContext, fillRect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//-(UIImage*)getSubImage:(CGRect)rect
//{
//    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
//    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
//    UIGraphicsBeginImageContext(smallBounds.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextDrawImage(context, smallBounds, subImageRef);
//    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
//    UIGraphicsEndImageContext();
//    CGImageRelease(subImageRef);
//    return smallImage;
//}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//1258291.2
+ (UIImage *)scaledForUpload:(UIImage *)image{
    if (!image) {
        return nil;
    }
    NSData* data ;
    for (float i = 1.0; i >= 0.1; i = i-0.1) {
        data = UIImageJPEGRepresentation(image, i);
        if (data.length < 524288 ) {
            break;
        }
    }
    UIImage *newImage = [UIImage imageWithData: data];
    return newImage;
}



@end
