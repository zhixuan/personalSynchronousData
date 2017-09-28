//
//  AiPuThemeUIKit.h
//  AIPuTravelProduct
//
//  Created by 张利广 on 15/7/7.
//  Copyright (c) 2015年 BeiJing AiPuTechnology Co.,LTD. All rights reserved.
//

#ifndef AIPuTravelProduct_AiPuThemeUIKit_h
#define AIPuTravelProduct_AiPuThemeUIKit_h

#import "AiPuThemeColor.h"                  //项目颜色
#import "AiPuThemeFontSize.h"
#import "AiPuThemeScreenSize.h"
#import "AiPuThemeTextContent.h"
#import "LvYeFMSetting.h"


#ifndef __OPTIMIZE__
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(...) {}
#endif


#endif
