//
//  AppDelegate.h
//  AIPuTravelProduct
//
//  Created by 张利广 on 15/7/7.
//  Copyright (c) 2015年 BeiJing AiPuTechnology Co.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/*!
 * @breif 倒计时处理
 * @See
 */
@property (nonatomic,strong)           NSTimer               *timer;

/*!
 * @breif 倒计时读秒
 * @See
 */
@property (nonatomic,assign)           NSInteger             currentSec;


/*!
 * @breif 倒计时读秒
 * @See
 */
@property (nonatomic,assign)           int                  productTourId;

@end
