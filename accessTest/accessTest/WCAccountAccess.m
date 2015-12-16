//
//  WCAccountAccess.m
//  accessTest
//
//  Created by wochu on 15/11/26.
//  Copyright © 2015年 accessTest. All rights reserved.
//

#import "WCAccountAccess.h"

@implementation WCAccountAccess

/**
 *  登陆
 */
+ (void)getLoginWithAccount:(NSString *)account password:(NSString *)password clientId:(NSString *)clientId grantType:(NSString *)grantType action:(WCLoginModelAction)action  {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"password" forKey:@"grant_type"];
    [parameters setObject:account forKey:@"UserName"];
    [parameters setObject:password forKey:@"password"];
    //    NSDictionary *parameter = [self assembleParametersWithKey:@"parameters" parameters:parameters];
    [self setOnceRequestHTTPSerailizer];
    [self POST:@"token" parameters:parameters action:^(NSURLSessionDataTask *task, id responeObject, NSError *error) {
        if (error) {
            return action(nil,error);
        }else {
            return action(responeObject,nil);
        }
    }];
}

@end
