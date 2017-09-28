//
//  HTTPClient+CapitalManage.m
//  AIPuTravelProduct
//
//  Created by ZhangLiGuang on 17/9/28.
//  Copyright © 2017年 BeiJing AiPuTechnology Co.,LTD. All rights reserved.
//

#import "HTTPClient+CapitalManage.h"

@implementation HTTPClient (CapitalManage)
/**
 *  @method
 *
 *  @brief          查找用户可使用的银行卡所属银行列表
 *
 */
- (AFHTTPRequestOperation *)sOneCapitalManangeBankSpareListInfor:(WebAPIRequestCompletionBlock)completionBlock{

    
    return [self getPath:@"capitalManage/bankSpareList"
               parameters:nil
               completion:completionBlock];
}

/**
 *  @method
 *
 *  @brief          查找 该俱乐部下,所有绑定的银行卡信息
 *
 */
- (AFHTTPRequestOperation *)sOneCapitalManageClubBankListInfor:(NSString *)clubID
                                           withCompletionBlock:(WebAPIRequestCompletionBlock)completionBlock{
    
    
    NSDictionary *paramDict = @{@"clubID":clubID};
    return [self getPath:@"capitalManage/clubBankList"
              parameters:paramDict
              completion:completionBlock];
}

/**
 *  @method
 *
 *  @brief          查找 该俱乐部下,所有绑定的银行卡信息
 *
 */
- (AFHTTPRequestOperation *)sOneCapitalManageAddBankInforWith:(NSString *)clubID
                                                       bankId:(NSString *)bankId
                                                  accountCode:(NSString*)accountCode
                                                  accountName:(NSString *)accountName
                                                     openBank:(NSString *)openBank
                                                     isPublic:(BOOL)isPublic
                                          withCompletionBlock:(WebAPIRequestCompletionBlock)completionBlock{
    
    NSDictionary *paramDict = @{@"clubID":clubID};
    return [self postPath:@"capitalManage/addClubBank"
              parameters:paramDict
              completion:completionBlock];
}
@end
