//
//  LvYeFMSetting.h
//  AIPuTravelProduct
//
//  Created by ZhangLiGuang on 17/9/19.
//  Copyright © 2017年 BeiJing AiPuTechnology Co.,LTD. All rights reserved.
//


#import <Foundation/Foundation.h>

#define LvYeFMShareSetting  [LvYeFMSetting sharedSettings]

@interface LvYeFMSetting : NSObject

/*!
 * @breif 操作时间
 * @See
 */
@property (nonatomic , assign)      int     synchronizeTimeIntervalInt;


/*!
 * @breif 操作开始 ID 内容
 * @See
 */
@property (nonatomic , copy)      NSString  *synchronizeProductIdStr;


/*!
 * @breif 操作日志内容
 * @See
 */
@property (nonatomic , copy)      NSString  *synchronizeLogsStr;

+ (LvYeFMSetting *)sharedSettings;

@end
