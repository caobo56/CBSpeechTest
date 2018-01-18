//
//  CBVerifyTool.h
//  ABCreditApp
//
//  Created by caobo56 on 2017/2/24.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBVerifyTool : NSObject

/**
 验证身份证号码

 @param value 身份证号码Str
 @return YES/NO
 */
+ (BOOL)validateIDCardNumber:(NSString *)value;


/**
 验证手机号码

 @param mobileNum mobileNum
 @return YES/NO
 */
+ (BOOL)validateMobileNumber:(NSString *)mobileNum;

/**
 验证邮箱

 @param email email
 @return YES/NO
 */
+(BOOL)validateEmail:(NSString *)email;

/**
 验证邮政编码

 @param zipcode zipcode
 @return YES/NO
 */
+(BOOL)validateZipcode:(NSString*)zipcode;

/**
 验证银行卡号

 @param cardNo cardNo description
 @return YES/NO
 */
+(BOOL)validateCardNo:(NSString*) cardNo;


/**
 根据银行卡或获取银行名称

 @param idCard idCard
 @return return cardName
 */
+(NSString *)returnBankName:(NSString*)idCard;


/**
 验证组织机构代码
 
 @param code code
 @return YES/NO
 */
+(BOOL)validEntpCode:(NSString *)code;

/**
 验证统一社会信用代码
 
 @param code code
 @return YES/NO
 */
+(BOOL)validSocialCreditCode:(NSString *)code;

/**
 纳税登记开户行账号
 @param code code
 @return YES/NO
 */
+(BOOL)validtaxBankNo:(NSString *)code;

/**
 金融机构编码
 //15位数字和大写字母（必须含有数字和字母）
 ^[A-Z][0-9]{4}[A-Z][0-9]{9}$
 */
+(BOOL)validfinancialCode:(NSString *)code;


/**
 SWIFTCODE
 ^[A-Z]{4}[C][N][2-9A-Z]{2}([0-9A-Z]{3})?$
 */
+(BOOL)validSWIFTCODECode:(NSString *)code;


/**
 纳税人识别号
 ^((\d{15})|(\d{6}[0-9A-Z]{9}))$
 */
+(BOOL)validTaxpayerCode:(NSString *)code;


//组织机构代码
//开户行账号

/**
 座机区号
 ^(0\d{2,3})$
 */
+(BOOL)validTelPrefixCode:(NSString *)code;

/**
 座机号码
 ^((\d{7,8}(-[0-9]{1,8})?)|(1[3584]\d{9}))$
 */
+(BOOL)validTelCode:(NSString *)code;

@end
