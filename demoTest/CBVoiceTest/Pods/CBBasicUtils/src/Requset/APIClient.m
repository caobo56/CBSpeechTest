//
//  APIClient.m
//  ABCreditApp
//
//  Created by caobo56 on 2017/2/22.
//  Copyright © 2017年 caobo56. All rights reserved.
//



#import "APIClient.h"
#import "CBURLSession.h"


NSString* const NetworkMethod_Get     =@"GET";
NSString* const NetworkMethod_Post    =@"POST";
NSString* const NetworkMethod_Put     =@"PUT";
NSString* const NetworkMethod_Delete  =@"DELETE";

NSString* const NetworkErrorDomain    =@"NetworkError";
NSString* const IMGErrorDomain        =@"IMGError";

@interface APIClient()<NSURLSessionDelegate>

@end

@implementation APIClient

+(void)sendUrl:(NSString*)urlStr method:(NSString*)method params:(NSDictionary*)param token:(NSString *)token completion:(NetworkCompletion)completion{
#if DEBUG
    if (token) {
        NSLog(@"Use Token For DEBUG:%@",token);
    }
#endif
    __block NSError* errOut = nil;
    __block NSDictionary * dataOut = nil;
    
    NSString* url;
    if ([urlStr hasPrefix:@"https:/"] || [urlStr hasPrefix:@"http:/"]) {
        url=urlStr;
    }else {
        NSDictionary* ui= @{@"statusCode":@(0),
                            @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_ReqURLError]};
        errOut = M_ERROR_INFO(NetworkErrCode_ReqURLError,ui);
        completion(errOut,nil);
        return;
    }
    
    NSMutableURLRequest *request = CreateRequest(url, method, param, token);

    CBURLSession *session = [CBURLSession sharedURLSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (error) {
            if (httpResponse.statusCode != 200) {
                NSDictionary* ui= @{@"statusCode":@(httpResponse.statusCode),
                                    @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_RespSCNot200],
                                    @"data":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                errOut = M_ERROR_INFO(NetworkErrCode_RespSCNot200,ui);
            }
        }
        
        if (!errOut) {
            if (!data) {
                NSDictionary* ui= @{@"statusCode":@(httpResponse.statusCode),
                                    @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_ReqParamError],
                                    @"data":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                errOut = M_ERROR_INFO(NetworkErrCode_ReqParamError,ui);
            }else{
                dataOut = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (dataOut && [dataOut isKindOfClass:[NSDictionary class]])  {
                    errOut = nil;
                }else{
                    NSDictionary* ui=@{@"statusCode":@(httpResponse.statusCode),
                                       @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_ReqParamError],
                                       @"data":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                    errOut = M_ERROR_INFO(NetworkErrCode_ReqParamError,ui);
                }
            }
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
#if DEBUG
            NSLog(@"data:%@",data);
            NSLog(@"error:%@",error);
#endif
            completion(errOut,dataOut);
        });
    }];
    
    [sessionDataTask resume];
}

+(void)pre_sendUrl:(NSString*)urlStr method:(NSString*)method params:(NSDictionary*)param token:(NSString *)token completion:(NetworkCompletion)completion{
#if DEBUG
    if (token) {
        NSLog(@"Use Token For DEBUG:%@",token);
    }
#endif
    __block NSError* errOut = nil;
    __block NSDictionary * dataOut = nil;
    
    NSString* url;
    if ([urlStr hasPrefix:@"https:/"] || [urlStr hasPrefix:@"http:/"]) {
        url=urlStr;
    }else {
        NSDictionary* ui= @{@"statusCode":@(0),
                            @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_ReqURLError]};
        errOut = M_ERROR_INFO(NetworkErrCode_ReqURLError,ui);
        completion(errOut,nil);
        return;
    }
    
    NSMutableURLRequest *request = CreateRequestPre(url, method, param, token);
    
    CBURLSession *session = [CBURLSession sharedURLSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (error) {
            if (httpResponse.statusCode != 200) {
                NSDictionary* ui= @{@"statusCode":@(httpResponse.statusCode),
                                    @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_RespSCNot200],
                                    @"data":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                errOut = M_ERROR_INFO(NetworkErrCode_RespSCNot200,ui);
            }
        }
        
        if (!errOut) {
            if (!data) {
                NSDictionary* ui= @{@"statusCode":@(httpResponse.statusCode),
                                    @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_ReqParamError],
                                    @"data":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                errOut = M_ERROR_INFO(NetworkErrCode_ReqParamError,ui);
            }else{
                dataOut = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (dataOut && [dataOut isKindOfClass:[NSDictionary class]])  {
                    errOut = nil;
                }else{
                    NSDictionary* ui=@{@"statusCode":@(httpResponse.statusCode),
                                       @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_ReqParamError],
                                       @"data":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                    errOut = M_ERROR_INFO(NetworkErrCode_ReqParamError,ui);
                }
            }
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
#if DEBUG
            NSLog(@"data:%@",data);
            NSLog(@"error:%@",error);
#endif
            completion(errOut,dataOut);
        });
    }];
    
    [sessionDataTask resume];
}


+(void)sendUrl:(NSString *)urlStr method:(NSString *)method params:(NSDictionary *)param image:(UIImage *)image token:(NSString *)token completion:(NetworkCompletion)completion{
#if DEBUG
    if (token) {
        NSLog(@"Use Token For DEBUG:%@",token);
    }
#endif
    __block NSError* errOut = nil;
    __block NSDictionary * dataOut = nil;

    NSString* url;
    if ([urlStr hasPrefix:@"https:/"] || [urlStr hasPrefix:@"http:/"]) {
        url=urlStr;
    }else {
        NSDictionary* ui= @{@"statusCode":@(0),
                            @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_ReqURLError]};
        errOut = M_ERROR_INFO(NetworkErrCode_ReqURLError,ui);
        completion(errOut,nil);
        return;
    }
    
    if (!image) {
        NSDictionary* ui= @{@"statusCode":@(0),
                            @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_ReqParamError]};
        errOut = M_ERROR_INFO(NetworkErrCode_ReqParamError,ui);
        return;
    }
    
    NSMutableURLRequest *request = CreateRequestPre(url, method, param, token);
    
    // 设置请求头数据 。  boundary：边界
    [request setValue:@"multipart/form-data; boundary=----WebKitFormBoundaryftnnT7s3iF7wV5q6" forHTTPHeaderField:@"Content-Type"];
    
    // 给请求体加入固定格式数据
    NSMutableData *data = [NSMutableData data];
    /*******************设置文件参数***********************/
    // 设置边界 注：必须和请求头数据设置的边界 一样， 前面多两个“-”；（字符串 转 data 数据）
    [data appendData:[@"------WebKitFormBoundaryftnnT7s3iF7wV5q6" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 设置传入数据的基本属性， 包括有 传入方式 data ，传入的类型（名称） ，传入的文件名， 。
    [data appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"image.jpeg\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 设置 内容的类型  “文件类型/扩展名” MIME中的
    [data appendData:[@"Content-Type: image/jpeg" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 加入数据内容
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSData *imageData = UIImagePNGRepresentation(image);
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    [data appendData:imageData];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 设置边界
    [data appendData:[@"------WebKitFormBoundaryftnnT7s3iF7wV5q6" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    /******************非文件参数***************************/
    // 内容设置 ， 设置传入的类型（名称）
    [data appendData:[@"Content-Disposition: form-data; name=\"username\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 传入的名称username = lxl
    [data appendData:[@"lxl" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 退出边界
    [data appendData:[@"------WebKitFormBoundaryftnnT7s3iF7wV5q6--" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    request.HTTPBody = data;
    // 设置请求方式 post
    request.HTTPMethod = method;
    
    CBURLSession *session = [CBURLSession sharedURLSessionForUpload];

    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//      NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (error) {
            if (httpResponse.statusCode != 200) {
                NSDictionary* ui= @{@"statusCode":@(httpResponse.statusCode),
                                    @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_RespSCNot200],
                                    @"data":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                errOut = M_ERROR_INFO(NetworkErrCode_RespSCNot200,ui);
            }
        }
        
        if (!errOut) {
            if (!data) {
                NSDictionary* ui= @{@"statusCode":@(httpResponse.statusCode),
                                    @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_ReqParamError],
                                    @"data":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                errOut = M_ERROR_INFO(NetworkErrCode_ReqParamError,ui);
            }else{
                dataOut = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (dataOut && [dataOut isKindOfClass:[NSDictionary class]])  {
                    errOut = nil;
                }else{
                    NSDictionary* ui=@{@"statusCode":@(httpResponse.statusCode),
                                       @"errorMsg":[APIClient NetWorkErrorMsg:NetworkErrCode_ReqParamError],
                                       @"data":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                    errOut = M_ERROR_INFO(NetworkErrCode_ReqParamError,ui);
                }
            }
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
#ifdef DEBUG
            NSLog(@"%@:%@\n%@\nToken=%@",method,url,param,token);
            NSLog(@"data:%@\nerror:%@",data,error);
#endif
            completion(errOut,dataOut);
        });

    }];
    [task resume];
}



#pragma mark - NSURLSessionTaskDelegate

/**
 *  监听上传进度
 *
 *  @param session                  session
 *  @param task                     上传任务
 *  @param bytesSent                当前这次发送的数据
 *  @param totalBytesSent           已经发送的总数据
 *  @param totalBytesExpectedToSend 期望发送的总数据
 */

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    float progress = (float)1.0*totalBytesSent / totalBytesExpectedToSend;
    NSLog(@"%f",progress);
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"%s",__func__);
}


#pragma mark - CreateRequest

static NSMutableURLRequest* CreateRequest(NSString* url,NSString* method,NSDictionary* param,NSString* token){
    
    if ([method isEqualToString:NetworkMethod_Get] || [method isEqualToString:NetworkMethod_Delete]) {
        if (param) {
            NSArray* keys=[param allKeys];
            if ([keys count]>0) {
                NSMutableArray* arr=[NSMutableArray arrayWithCapacity:[keys count]];
                for (NSString* key in keys) {
                    [arr addObject:[NSString stringWithFormat:@"%@=%@",key,EgEncodeToPercentEscapeString([param[key] description])]];
                }
                url=[url stringByAppendingFormat:@"?%@",[arr componentsJoinedByString:@"&"]];
            }
        }
        
#ifdef DEBUG
        NSLog(@"%@:%@\nToken=%@",method,url,token);
#endif
    }
    
    NSMutableURLRequest* req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setTimeoutInterval:M_TIMEOUT];
    if (token) {
        [req setValue:token forHTTPHeaderField:@"token"];
    }
    [req setCachePolicy:NSURLRequestReloadRevalidatingCacheData];
    //验证本地数据与远程数据是否相同，如果不同则下载远程数据，否则使用本地数据
    
    //    [req setValue:mDevId forHTTPHeaderField:@"mDevId"];
    //    [req setValue:MGEgSignedString(mDevId) forHTTPHeaderField:@"mSignedDeviceId"];
    [req setValue:@"ABCreditApp" forHTTPHeaderField:@"User-Agent"];
    [req setValue:[[NSBundle mainBundle] bundleIdentifier] forHTTPHeaderField:@"AppId"];
    [req setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"AppVersion"];
    [req setValue:@"iOS" forHTTPHeaderField:@"System"];
    [req setValue:@"iTunes" forHTTPHeaderField:@"Channel"];
    
    [req setHTTPMethod:method];
    
    if ([method isEqualToString:NetworkMethod_Post] || [method isEqualToString:NetworkMethod_Put]) {
        if (param) {
            NSData* dataC = [NSJSONSerialization dataWithJSONObject:param options:0 error:NULL];
            [req setHTTPBody:dataC];
        }
#ifdef DEBUG
        NSLog(@"%@:%@\n%@\nToken=%@",method,url,param,token);
#endif
    }
    
    return req;
}

static NSMutableURLRequest* CreateRequestPre(NSString* url,NSString* method,NSDictionary* param,NSString* token){
    
    if ([method isEqualToString:NetworkMethod_Get] || [method isEqualToString:NetworkMethod_Post]) {
        if (param) {
            NSArray* keys=[param allKeys];
            if ([keys count]>0) {
                NSMutableArray* arr=[NSMutableArray arrayWithCapacity:[keys count]];
                for (NSString* key in keys) {
                    [arr addObject:[NSString stringWithFormat:@"%@=%@",key,EgEncodeToPercentEscapeString([param[key] description])]];
                }
                url=[url stringByAppendingFormat:@"?%@",[arr componentsJoinedByString:@"&"]];
            }
        }
        
#ifdef DEBUG
        NSLog(@"%@:%@\nToken=%@",method,url,token);
#endif
    }
    
    NSMutableURLRequest* req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setTimeoutInterval:M_TIMEOUT];
    if (token) {
        [req setValue:token forHTTPHeaderField:@"token"];
    }
    [req setCachePolicy:NSURLRequestReloadRevalidatingCacheData];
    //验证本地数据与远程数据是否相同，如果不同则下载远程数据，否则使用本地数据
    
    [req setValue:@"ABCreditApp" forHTTPHeaderField:@"User-Agent"];
    [req setValue:[[NSBundle mainBundle] bundleIdentifier] forHTTPHeaderField:@"AppId"];
    [req setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"AppVersion"];
    [req setValue:@"iOS" forHTTPHeaderField:@"System"];
    [req setValue:@"iTunes" forHTTPHeaderField:@"Channel"];
    
    [req setHTTPMethod:method];
    
    return req;
}


NSString* EgEncodeToPercentEscapeString(NSString *input)
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)input,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
}


/**
 NetworkErrCode_Unknown=0,
 NetworkErrCode_ReqParamError,
 NetworkErrCode_ReqURLError,
 NetworkErrCode_RespSCNot200
 
 @param input ErrorType
 @return NetWorkErrorMsg
 */
+(NSString* )NetWorkErrorMsg:(NSInteger)input{
    NSString * errorMsg = @"";
    
    switch (input) {
        case NetworkErrCode_Unknown:
            errorMsg = @"未知类型错误！";
            break;
        case NetworkErrCode_ReqParamError:
            errorMsg = @"后台服务访问出错！";
            break;
        case NetworkErrCode_ReqURLError:
            errorMsg = @"访问地址不存在！";
            break;
        case NetworkErrCode_RespSCNot200:
            errorMsg = @"服务器访问异常！";
            break;
        default:
            break;
    }
    return errorMsg;
}


@end
