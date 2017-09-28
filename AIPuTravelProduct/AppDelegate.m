//
//  AppDelegate.m
//  AIPuTravelProduct
//
//  Created by 张利广 on 15/7/7.
//  Copyright (c) 2015年 BeiJing AiPuTechnology Co.,LTD. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPClient.h"
#import "HTTPClient+RegisterOrLogIn.h"
#import "HTTPClient+SOneHuodongParam.h"
#import "XCCurrentUserInfo.h"
#import "FirstViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    FirstViewController *viewController = [[FirstViewController alloc]init];
    viewController.title=@"测试";
    UINavigationController * navigat = [[UINavigationController alloc]initWithRootViewController:viewController];
    [self.window setRootViewController:navigat];
    
    
    
//    [FMHTTPClientForSOneAPI sOneSelectedOrderDetail:@"1557s1457y102019842" withCompletion:^(WebAPIResponse *response) {
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            if (response.code == WebAPIResponseCodeSuccessForHundred) {
//                
//                NSDictionary  *responeDic = ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
//                if (responeDic.count > 0) {
//                    ///将数据本地化处理
////                    NSLog(@"eventId is %@",responeDic);
//                    
//                    if([ObjForKeyInUnserializedJSONDic(responeDic, @"contact") isKindOfClass:[NSDictionary class]]){
//                        
//                        NSDictionary *contactDictionary = (NSDictionary *)ObjForKeyInUnserializedJSONDic(responeDic, @"contact");
//                        NSLog(@"contactDictionary is %@", contactDictionary);
//                    }
//                    
//                    if ([ObjForKeyInUnserializedJSONDic(responeDic, @"traveller") isKindOfClass:[NSArray class]]) {
//                        NSArray *travellerArray = (NSArray *)ObjForKeyInUnserializedJSONDic(responeDic, @"traveller");
//                        if(travellerArray != NULL){
//                            for (NSDictionary *dictionary in travellerArray) {
//                                NSLog(@"traveller Dictionary is %@",dictionary);
//                            }
//                        }
//                    }
//                }
//                
//            }
//        });
//
//    }];
//    
//    
//    [FMHTTPClientForSOneAPI sOneSelectedHuoDongTypeCompletion:^(WebAPIResponse *response) {
//       
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            if (response.code == WebAPIResponseCodeSuccessForHundred) {
////                NSLog(@"%@",ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData));
//                
//                NSArray  *responeDic = ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
//                if (responeDic.count > 0) {
//                    ///将数据本地化处理
//                    NSLog(@"eventId is %@",responeDic);
//                    
//                    for (NSDictionary * itemDic in responeDic) {
//                        NSString *cityNameStr = StringForKeyInUnserializedJSONDic(itemDic, @"name");
//                        NSString *os_city_id = StringForKeyInUnserializedJSONDic(itemDic, @"tour_type_id");
//                        
//                        NSLog(@"tour_type_id is %@ \t name is %@",os_city_id,cityNameStr);
//                    }
//                }
//
//            }
//        });
//    }];
//    
//    [FMHTTPClientForSOneAPI sOneSelectedHuoDongSendCityInforCompletion:^(WebAPIResponse *response) {
//      
//        
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            if (response.code == WebAPIResponseCodeSuccessForHundred) {
//                NSArray  *responeDic = ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
//                if (responeDic.count > 0) {
//                    ///将数据本地化处理
//                    NSLog(@"eventId is %@",responeDic);
//                    
//                    for (NSDictionary * itemDic in responeDic) {
//                        NSString *cityNameStr = StringForKeyInUnserializedJSONDic(itemDic, @"city_name");
//                        NSString *os_city_id = StringForKeyInUnserializedJSONDic(itemDic, @"os_city_id");
//                        
//                        NSLog(@"os_city_id is %@ \t cityNameStr is %@",os_city_id,cityNameStr);
//                    }
//                }
//            }
//        });
//
//    }];
//    
    
    
   
    self.currentSec=10;
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.4f target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
    ///本次同步,,同步到 S1104410...同步时间:2017-09-18 16:09:31
    self.productTourId = 104273;

   
     
    [self.window makeKeyAndVisible];

    return YES;

}
- (void)timeChange
{
    self.currentSec--;
    if (self.currentSec<=0) {
        NSLog(@"运行结束了...时间结束")
        [self.timer invalidate];
    }else{
        if (self.currentSec%2 == 0) {
            self.productTourId +=1;
            NSString *prodcutId = [NSString stringWithFormat:@"%i",self.productTourId];
            [FMHTTPClientSynchronizeAPI autoSysS1TourProductInforWithProductId:prodcutId completion:^(WebAPIResponse *response) {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    if (response.code == WebAPIResponseCodeSuccessForHundred) {
                        NSDictionary  *responeDic = ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                        if (responeDic.count > 0) {
                            ///将数据本地化处理
                            NSLog(@"eventId is %@",StringForKeyInUnserializedJSONDic(responeDic, @"eventId"));
                        }
                    }else{
                        NSLog("同步失败的是: id --> %@",prodcutId );
                    }
                });
            }];

            
        }
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
