//
//  WCBaseAccess.m
//  accessTest
//
//  Created by wochu on 15/11/26.
//  Copyright © 2015年 accessTest. All rights reserved.
//

#import "WCBaseAccess.h"

static NSString *__tempConfigue = @"client/v1/";


@implementation WCBaseAccess


+ (NSString *)assembleURLString:(NSString *)urlstring {
    return [NSString stringWithFormat:@"%@%@",__tempConfigue,urlstring];
}

/**
 *  post
 */
+ (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters action:(void(^)(NSURLSessionDataTask *task,id responeObject,NSError *error))action {
    NSURLSessionDataTask *dataTask = [self POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error = [WCBaseAccess _verifyResponseObject:responseObject];
        action(task,responseObject,error);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        action(task, nil, error);
    }];
    return dataTask;
}

+ (NSError *)_verifyResponseObject:(id)responseObject {
//    WCAssert([responseObject isKindOfClass:[NSDictionary class]] && @"不是字典。。。");
    if ([responseObject[@"hasError"] integerValue]) {
        NSError *error = [NSError errorWithDomain:@"WCBaseAccessDomain" code:-99 userInfo:@{NSLocalizedDescriptionKey : responseObject[@"errorMessage"]}];
        return error;
    }
    return nil;
}

@end
