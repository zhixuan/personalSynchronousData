//
//  LvYeFMSetting.m
//  AIPuTravelProduct
//
//  Created by ZhangLiGuang on 17/9/19.
//  Copyright © 2017年 BeiJing AiPuTechnology Co.,LTD. All rights reserved.
//

#import "LvYeFMSetting.h"

@implementation LvYeFMSetting


+ (LvYeFMSetting *)sharedSettings
{
    static LvYeFMSetting *_sharedSettings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSettings = [[LvYeFMSetting alloc] init];
    });
    
    return _sharedSettings;
}

- (id)init
{
    self = [super init];
    if (self == nil){
        return nil;
    }
    return self;
}

- (void)setSynchronizeTimeIntervalInt:(int)synchronizeTimeIntervalInt{

    [[NSUserDefaults standardUserDefaults] setInteger:synchronizeTimeIntervalInt forKey:@"SynchronizeTimeIntervalInt"];
}

- (int)synchronizeTimeIntervalInt{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"SynchronizeTimeIntervalInt"]) {
        return 0;
    }
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"SynchronizeTimeIntervalInt"];
}

- (void)setSynchronizeProductIdStr:(NSString *)synchronizeProductIdStr{
    [[NSUserDefaults standardUserDefaults] setObject:synchronizeProductIdStr  forKey:@"SnchronizeProductIdStr"];
}

- (NSString *)synchronizeProductIdStr{
    
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"SnchronizeProductIdStr"]) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"SnchronizeProductIdStr"];
}

- (void)setSynchronizeLogsStr:(NSString *)synchronizeLogsStr{
    [[NSUserDefaults standardUserDefaults] setObject:synchronizeLogsStr  forKey:@"SynchronizeLogsStr"];
}

- (NSString *)synchronizeLogsStr{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"SynchronizeLogsStr"]) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"SynchronizeLogsStr"];
}

@end
