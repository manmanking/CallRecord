//
//  TimeConvert.m
//  CallRecord
//
//  Created by manman on 2017/4/23.
//  Copyright © 2017年 manman. All rights reserved.
//

#import "TimeConvert.h"

@implementation TimeConvert

+ (NSString *)GetLocalCurrentTime:(NSString *)formatStr
{
    
    NSDate *date = [NSDate date]; // 获得时间对象
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    if (formatStr.length >1) {
        [formatter setDateFormat:@"%@"];
    }else
    {
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    }
    
    NSString *dateTime = [formatter stringFromDate:date];
    NSLog(@"GetLocalCurrentTime %@",dateTime);
    return dateTime;
}


@end
