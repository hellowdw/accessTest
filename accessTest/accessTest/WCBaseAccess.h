//
//  WCBaseAccess.h
//  accessTest
//
//  Created by wochu on 15/11/26.
//  Copyright © 2015年 accessTest. All rights reserved.
//

#import "WCBaseService.h"

@interface WCBaseAccess : WCBaseService
+ (NSString *)assembleURLString:(NSString *)urlstring;
/**
 *  post
 */
+ (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters action:(void(^)(NSURLSessionDataTask *task,id responeObject,NSError *error))action;
@end
