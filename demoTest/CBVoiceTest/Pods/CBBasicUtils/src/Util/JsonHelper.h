//
//  JsonHelper.h
//  jingduoduo
//
//  Created by caobo56 on 16/3/21.
//  Copyright © 2016年 totem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonHelper : NSObject


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/*!
 * @brief 把字典转换成格式化的JSON格式的字符串
 * @param dic 字典
 * @return 返回字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


/*!
 * @brief 把格式化的JSON格式的字符串转换成数组
 * @param jsonString JSON格式的字符串
 * @return 返回数组
 */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;


/*!
 * @brief 把数组转换成格式化的JSON格式的字符串
 * @param arr 数组
 * @return 返回字符串
 */
+ (NSString*)arrayToJson:(NSArray *)arr;



@end
