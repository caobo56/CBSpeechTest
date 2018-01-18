//
//  JsonHelper.m
//  jingduoduo
//
//  Created by caobo56 on 16/3/21.
//  Copyright © 2016年 totem. All rights reserved.
//

#import "JsonHelper.h"

@implementation JsonHelper

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}


/*!
 * @brief 把字典转换成格式化的JSON格式的字符串
 * @param dic 字典
 * @return 返回字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}



/*!
 * @brief 把格式化的JSON格式的字符串转换成数组
 * @param jsonString JSON格式的字符串
 * @return 返回数组
 */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString{
    
    if (jsonString == nil) {
        
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return arr;
}


/*!
 * @brief 把数组转换成格式化的JSON格式的字符串
 * @param arr 数组
 * @return 返回字符串
 */
+ (NSString*)arrayToJson:(NSArray *)arr{
    if (!arr) {
        return @"";
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}


@end
