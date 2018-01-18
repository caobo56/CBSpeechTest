//
//  CBVerifyTool.m
//  ABCreditApp
//
//  Created by caobo56 on 2017/2/24.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import "CBVerifyTool.h"

@implementation CBVerifyTool

/**
 /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$
 */
+ (BOOL)validateIDCardNumber:(NSString *)code {
    NSString *regex = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$|^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [codeTest evaluateWithObject:code];
}


/**
 ^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$
 */
+ (BOOL)validateMobileNumber:(NSString *)code
{
    NSString *regex = @"^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\\d{8})$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [codeTest evaluateWithObject:code];
}


+(BOOL)validateEmail:(NSString *)email{
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


+(BOOL)validateZipcode:(NSString*)value{
    NSString *regex = @"^[1-9][0-9]{5}$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [codeTest evaluateWithObject:value];
}

+(BOOL)validateCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

+(NSString *)returnBankName:(NSString*)idCard{
    
    if(idCard==nil || idCard.length<16 || idCard.length>19){
        NSLog(@"卡号不合法");
        return @"";
        
    }
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"plist"];
    NSDictionary* resultDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *bankBin = resultDic.allKeys;
    
    //6位Bin号
    NSString* cardbin_6 = [idCard substringWithRange:NSMakeRange(0, 6)];
    //8位Bin号
    NSString* cardbin_8 = [idCard substringWithRange:NSMakeRange(0, 8)];
    
    if ([bankBin containsObject:cardbin_6]) {
        return [resultDic objectForKey:cardbin_6];
    }else if ([bankBin containsObject:cardbin_8]){
        return [resultDic objectForKey:cardbin_8];
    }else{
        NSLog(@"plist文件中不存在请自行添加对应卡种");
        return @"";
    }
    return @"";
    
}



/**
 验证组织机构代码
 
 @param code code
 @return YES/NO
 */
+(BOOL)validEntpCode:(NSString *)code{
    if (code.length != 10)
    {
        return NO;
    }
    NSString *regex = @"[a-zA-Z0-9]{8}-[a-zA-Z0-9]";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [codeTest evaluateWithObject:code];
}

/**
 验证统一社会信用代码
 
 @param code code
 @return YES/NO
 */
+(BOOL)validSocialCreditCode:(NSString *)code{
    if (code.length != 18)
    {
        return NO;
    }
    NSString *regex = @"[^_IOZSVa-z\\W]{2}\\d{6}[^_IOZSVa-z\\W]{10}";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [codeTest evaluateWithObject:code];
}

/**
 纳税登记开户行账号
 @param code code
 @return YES/NO
 */
+(BOOL)validtaxBankNo:(NSString *)code{
    NSString *regex = @"^\\d{10,30}$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [codeTest evaluateWithObject:code];
}


/**
 金融机构编码
 ^[A-Z][0-9]{4}[A-Z][0-9]{9}$
 */
+(BOOL)validfinancialCode:(NSString *)code{
    NSString *regex = @"^[A-Z][0-9]{4}[A-Z][0-9]{9}$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [codeTest evaluateWithObject:code];
}

/**
 SWIFTCODE
 ^[A-Z]{4}[C][N][2-9A-Z]{2}([0-9A-Z]{3})?$
 */
+(BOOL)validSWIFTCODECode:(NSString *)code{
    NSString *regex = @"^[A-Z]{4}[C][N][2-9A-Z]{2}([0-9A-Z]{3})?$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [codeTest evaluateWithObject:code];
}

/**
 纳税人识别号
 ^((\d{15})|(\d{6}[0-9A-Z]{9}))$
 */
+(BOOL)validTaxpayerCode:(NSString *)code{
    NSString *regex = @"^((\\d{15})|(\\d{6}[0-9A-Z]{9}))$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [codeTest evaluateWithObject:code];
}


/**
 座机区号
 ^(0\d{2,3})$
 */
+(BOOL)validTelPrefixCode:(NSString *)code{
    NSString *regex = @"^(0\\d{2,3})$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [codeTest evaluateWithObject:code];
}

/**
 座机号码
 ^((\d{7,8}(-[0-9]{1,8})?)|(1[3584]\d{9}))$
 */
+(BOOL)validTelCode:(NSString *)code{
    NSString *regex = @"^((\\d{7,8}(-[0-9]{1,8})?)|(1[3584]\\d{9}))$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [codeTest evaluateWithObject:code];
}

@end

















