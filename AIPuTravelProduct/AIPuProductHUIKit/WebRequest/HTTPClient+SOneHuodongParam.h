//
//  HTTPClient+SOneHuodongParam.h
//  AIPuTravelProduct
//
//  Created by ZhangLiGuang on 17/9/7.
//  Copyright © 2017年 BeiJing AiPuTechnology Co.,LTD. All rights reserved.
//

#import "HTTPClient.h"

@interface HTTPClient (SOneHuodongParam)
/**
*  @method
*
*  @brief          用户登录操作请求数据
*
*  @param          phoneStr        手机号
*
*  @param          passwordStr     登录密码
*
*  @see            用户登录操作请求数据
*
*/
- (AFHTTPRequestOperation *)sOneSelectedHuoDongTypeCompletion:(WebAPIRequestCompletionBlock)completionBlock;

/**
 *  @method
 *
 *  @brief          用户登录操作请求数据
 *
 *  @param          phoneStr        手机号
 *
 *  @param          passwordStr     登录密码
 *
 *  @see            用户登录操作请求数据
 *
 */
- (AFHTTPRequestOperation *)sOneSelectedHuoDongSendCityInforCompletion:(WebAPIRequestCompletionBlock)completionBlock;

/**
 *  @method
 *
 *  @brief          用户登录操作请求数据
 *
 *  @param          phoneStr        手机号
 *
 *  @param          passwordStr     登录密码
 *
 *  @see            用户登录操作请求数据
 *
 */
- (AFHTTPRequestOperation *)sOneSelectedOrderDetail:(NSString *)orderNumber withCompletion:(WebAPIRequestCompletionBlock)completionBlock;
@end
