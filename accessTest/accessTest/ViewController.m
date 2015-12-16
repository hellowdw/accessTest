//
//  ViewController.m
//  accessTest
//
//  Created by wochu on 15/11/26.
//  Copyright © 2015年 accessTest. All rights reserved.
//

#import "ViewController.h"
#import "WCAccountAccess.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [WCAccountAccess getLoginWithAccount:@"13733180155" password:@"123456" clientId:nil grantType:nil action:^(NSDictionary *dict, NSError *error) {
        NSLog(@"---ViewController.h----%@",dict);
    }];
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
