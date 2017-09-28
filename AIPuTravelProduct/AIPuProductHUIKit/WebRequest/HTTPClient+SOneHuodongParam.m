//
//  HTTPClient+SOneHuodongParam.m
//  AIPuTravelProduct
//
//  Created by ZhangLiGuang on 17/9/7.
//  Copyright © 2017年 BeiJing AiPuTechnology Co.,LTD. All rights reserved.
//

#import "HTTPClient+SOneHuodongParam.h"

@implementation HTTPClient (SOneHuodongParam)
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
- (AFHTTPRequestOperation *)sOneSelectedHuoDongTypeCompletion:(WebAPIRequestCompletionBlock)completionBlock{
    
    return [self getPath:@"sOneActivity/activityType" parameters:nil
              completion:completionBlock];

}

- (AFHTTPRequestOperation *)sOneSelectedHuoDongSendCityInforCompletion:(WebAPIRequestCompletionBlock)completionBlock{
    return [self getPath:@"sOneActivity/activitySendCity" parameters:nil
              completion:completionBlock];
}
- (AFHTTPRequestOperation *)sOneSelectedOrderDetail:(NSString *)orderNumber withCompletion:(WebAPIRequestCompletionBlock)completionBlock{
    
    
    NSDictionary *paramDict = @{@"orderNumber":orderNumber};
    return [self postPath:@"orderManage/orderDetail" parameters:paramDict
              completion:completionBlock];

    
}
@end
