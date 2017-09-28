//
//  HTTPClient+CapitalManage.h
//  AIPuTravelProduct
//
//  Created by ZhangLiGuang on 17/9/28.
//  Copyright © 2017年 BeiJing AiPuTechnology Co.,LTD. All rights reserved.
//

#import "HTTPClient.h"

/**
 *
 *  资金管理处理
 **/
@interface HTTPClient (CapitalManage)

/**
 *  @method
 *
 *  @brief          查找用户可使用的银行卡所属银行列表
 *
 *  @param          null
 *
 *  @see            用户请求数据
 *
 */
- (AFHTTPRequestOperation *)sOneCapitalManangeBankSpareListInfor:(WebAPIRequestCompletionBlock)completionBlock;

/**
 *  @method
 *
 *  @brief          查找 该俱乐部下,所有绑定的银行卡信息
 *
 *  @param          clubID      俱乐部ID
 *
 *  @see            用户请求数据
 *
 */
- (AFHTTPRequestOperation *)sOneCapitalManageClubBankListInfor:(NSString *)clubID
                                           withCompletionBlock:(WebAPIRequestCompletionBlock)completionBlock;

/**
 *  @method
 *
 *  @brief          查找 该俱乐部下,所有绑定的银行卡信息
 *
 *  @param          clubID          俱乐部ID
 *
 *  @param          bankId          银行编号
 *
 *  @param          accountCode     银行卡卡号
 *
 *  @param          accountName     开户行名称
 *
 *  @param          openBank        开户行地址
 *
 *  @param          isPublic        是否为个人账户,=YES, 个人账户;=NO, 对公账户;
 *
 *  @see            用户请求数据
 *
 */
- (AFHTTPRequestOperation *)sOneCapitalManageAddBankInforWith:(NSString *)clubID
                                                       bankId:(NSString *)bankId
                                                  accountCode:(NSString*)accountCode
                                                  accountName:(NSString *)accountName
                                                     openBank:(NSString *)openBank
                                                     isPublic:(BOOL)isPublic
                                          withCompletionBlock:(WebAPIRequestCompletionBlock)completionBlock;


@end
