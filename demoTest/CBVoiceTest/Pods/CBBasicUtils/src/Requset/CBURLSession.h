//
//  CBURLSession.h
//  ABCreditApp
//
//  Created by caobo56 on 2017/2/22.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBURLSession : NSURLSession


/**
 sharedURLSession

 @return return shareURLSession shareURLSession
 */
+(instancetype)sharedURLSession;


+(instancetype) sharedURLSessionForUpload;
@end
