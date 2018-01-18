//
//  CBURLSession.m
//  ABCreditApp
//
//  Created by caobo56 on 2017/2/22.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import "CBURLSession.h"

static CBURLSession *shareURLSession = nil;


@implementation CBURLSession

+(instancetype) sharedURLSession{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPMaximumConnectionsPerHost = 10;
        NSString *userAgentString = @"iPhone AppleWebKit";
        NSString *authString = @"";
        configuration.HTTPAdditionalHeaders = @{@"Accept": @"application/json",
                                                @"Accept-Language": @"en",
                                                @"Authorization": authString,
                                                @"User-Agent": userAgentString};
        shareURLSession = (CBURLSession *)[super sessionWithConfiguration:configuration];
    });
    return shareURLSession;
}

+(instancetype) sharedURLSessionForUpload{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPMaximumConnectionsPerHost = 60;
        NSString *userAgentString = @"iPhone AppleWebKit";
        NSString *authString = @"";
        configuration.HTTPAdditionalHeaders = @{@"Accept": @"application/json",
                                                @"Accept-Language": @"en",
                                                @"Authorization": authString,
                                                @"User-Agent": userAgentString};
        shareURLSession = (CBURLSession *)[super sessionWithConfiguration:configuration];
    });
    return shareURLSession;
}


+(id)allocWithZone:(struct _NSZone *)zone{
    return [CBURLSession sharedURLSession];
}

-(id)copyWithZone:(struct _NSZone *)zone{
    return [CBURLSession sharedURLSession];
}


@end
