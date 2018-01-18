//
//  APIClient.h
//  ABCreditApp
//
//  Created by caobo56 on 2017/2/22.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define M_TIMEOUT 15.0
#define M_ERROR(c)          [NSError errorWithDomain:NetworkErrorDomain code:(c) userInfo:nil]
#define M_ERROR_INFO(c,ui)  [NSError errorWithDomain:NetworkErrorDomain code:(c) userInfo:(ui)]

extern NSString* const NetworkMethod_Get;
extern NSString* const NetworkMethod_Post;
extern NSString* const NetworkMethod_Put;
extern NSString* const NetworkMethod_Delete;

extern NSString* const NetworkErrorDomain;
extern NSString* const IMGErrorDomain;

enum {
    NetworkErrCode_Unknown = 0,
    NetworkErrCode_ReqParamError,
    NetworkErrCode_ReqURLError,
    NetworkErrCode_RespSCNot200,
    NetworkErrCode_IMGError
};

typedef void(^NetworkCompletion)(NSError* error,NSDictionary* data);

@interface APIClient : NSObject

+(void)sendUrl:(NSString*)url method:(NSString*)method params:(NSDictionary*)param token:(NSString *)token completion:(NetworkCompletion)completion;

+(void)pre_sendUrl:(NSString*)urlStr method:(NSString*)method params:(NSDictionary*)param token:(NSString *)token completion:(NetworkCompletion)completion;

//串行

//并发

//图片上传
+(void)sendUrl:(NSString *)url method:(NSString *)method params:(NSDictionary *)param image:(UIImage *)image token:(NSString *)token completion:(NetworkCompletion)completion;

+(NSString* )NetWorkErrorMsg:(NSInteger)input;

@end
