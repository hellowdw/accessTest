//
//  WCBaseService.m
//  accessTest
//
//  Created by wochu on 15/11/26.
//  Copyright © 2015年 accessTest. All rights reserved.
//

#import "WCBaseService.h"
#import "VersionControl.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@interface WCBaseService ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@property (nonatomic, strong) AFJSONRequestSerializer *jsonRequestSerializer;

@end
@implementation WCBaseService


#pragma mark - init

+ (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
   NSURLSessionDataTask *dataTask = [[WCBaseService _shareService].manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
       success (task,responseObject);
       if (responseObject) {
           NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
           NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
           NSLog(@"--**-%@-**--",dataString);
       }
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"%@",error.localizedDescription);
       failure (task,error);
   }];
    
    return dataTask;
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
//    if ([[WCAppGlobal defaulAppGlobal] getAccessToken]) {
//        [[[[self _shareService] manager] requestSerializer] setValue:[[WCAppGlobal defaulAppGlobal] getAccessToken] forHTTPHeaderField:@"Authorization"];
//    }
    NSURLSessionDataTask *dataTask = [[[self _shareService] manager] POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
#ifdef DEBUG
        //        if ([responseObject isKindOfClass:[NSDictionary class]]) {
        //            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
        //            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //            DLog(@"%@", dataString);
        //        }
#endif
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"----error----%@", error.localizedDescription);
        failure(task, error);
    }];
    // 发送完毕改变json请求方式
//    [[[self _shareService] manager] setRequestSerializer:[[self _shareService] JSONRequestSerializer]];
    return dataTask;
}




- (instancetype)init {
    if (self = [super init]) {
        _manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:WCBaseConnectorAddress] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSLog(@"%@",WCBaseConnectorAddress);
    
        _manager.requestSerializer = [self jsonRequestSerializer];//请求数据是json类型
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        _manager.requestSerializer.timeoutInterval = 20;
        _manager.responseSerializer.acceptableStatusCodes = _manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 220)];
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    }
    return self;
}

#pragma mark - 实例化

+ (instancetype)_shareService {
    static WCBaseService *_service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _service = [[WCBaseService alloc]init];
    });
    return _service;
}

- (AFJSONRequestSerializer *)jsonRequestSerializer {
    if (!_jsonRequestSerializer) {
        _jsonRequestSerializer = [AFJSONRequestSerializer serializer];
    }
    return _jsonRequestSerializer;
}

- (AFHTTPRequestSerializer *)httpRequestSerializer {
    if (!_httpRequestSerializer) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return _httpRequestSerializer;
}


+ (void)setOnceRequestHTTPSerailizer {
    [[self _shareService] manager].requestSerializer = [[self _shareService] httpRequestSerializer];
}
@end
