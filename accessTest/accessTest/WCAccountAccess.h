//
//  WCAccountAccess.h
//  accessTest
//
//  Created by wochu on 15/11/26.
//  Copyright © 2015年 accessTest. All rights reserved.
//

#import "WCBaseAccess.h"

typedef void (^WCLoginModelAction)(NSDictionary *dict,NSError *error);

@interface WCAccountAccess : WCBaseAccess
+ (void)getLoginWithAccount:(NSString *)account password:(NSString *)password clientId:(NSString *)clientId grantType:(NSString *)grantType action:(WCLoginModelAction)action;
@end
