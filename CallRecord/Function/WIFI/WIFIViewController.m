//
//  WIFIViewController.m
//  CallRecord
//
//  Created by manman on 2017/5/4.
//  Copyright © 2017年 manman. All rights reserved.
//

#import <SystemConfiguration/CaptiveNetwork.h>
#import "WIFIViewController.h"

@interface WIFIViewController ()

@property (nonatomic,strong) UILabel *firstLabel;
@property (nonatomic,strong) UILabel *secondLabel;
@property (nonatomic,strong) UILabel *thirdLabel;


@end

@implementation WIFIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 300, 30)];
    _firstLabel.text = @"SSID:";
    [self.view addSubview:_firstLabel];
    
    _secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 300, 30)];
    _secondLabel.text = @"BSSID:";
    [self.view addSubview:_secondLabel];
    
    _thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 300, 30)];
    _thirdLabel.text = @"SSIDDATA:";
    [self.view addSubview:_thirdLabel];
    
    
    
    
    
    id info = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSString *str = info[@"SSID"];
        NSString *str2 = info[@"BSSID"];
        NSString *str3 = [[ NSString alloc] initWithData:info[@"SSIDDATA"] encoding:NSUTF8StringEncoding];
        NSLog(@"SSID:%@",str);
        NSLog(@"BSSID:%@",str2);
        NSLog(@"SSIDDATA:%@",str3);
        _firstLabel.text = [NSString stringWithFormat:@"SSID:%@",str];
        _secondLabel.text = [NSString stringWithFormat:@"BSSID:%@",str2];
        _thirdLabel.text = [NSString stringWithFormat:@"SSIDDATA:%@",str3];
        
        
    }
    
    
}


- (void)test
{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
