//
//  FirstViewController.m
//  AIPuTravelProduct
//
//  Created by ZhangLiGuang on 17/9/6.
//  Copyright © 2017年 BeiJing AiPuTechnology Co.,LTD. All rights reserved.
//

#import "FirstViewController.h"
#import "HTTPClient.h"
#import "HTTPClient+RegisterOrLogIn.h"
#import "HTTPClient+SOneHuodongParam.h"
#import "HTTPClient+CapitalManage.h"
#import "XCCurrentUserInfo.h"
#import "FirstViewController.h"


#define KBtnForDoneBeginTag             (108322)
#define KBtnForDoneSynchronizeTag       (108323)
#define KBtnForDoneFinishTag            (108324)




@interface FirstViewController ()<UITextFieldDelegate>

/*!
 * @breif 时间间隔
 * @See
 */
@property (nonatomic , weak)     UITextField        *synchronizeTimeIntegerField;

/*!
 * @breif 时间间隔
 * @See
 */
@property (nonatomic , weak)     UITextField        *synchronizeTourIDField;

/*!
 * @breif log显示框
 * @See
 */
@property (nonatomic , weak)      UITextView *logContentTextField;

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


/*!
 * @breif 同步操作按键
 * @See
 */
@property (nonatomic ,  weak)      UIButton                 *doneSynchronizeButton;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUserOperationView];
    
    
    [FMHTTPClientForSOneAPI sOneCapitalManangeBankSpareListInfor:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (response.code == WebAPIResponseCodeSuccessForHundred) {
                NSArray  *responeArray = (NSArray  *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                if (responeArray.count > 0) {
                    NSLog(@"responeArray is %@",responeArray);
                }
            }else{
               
            }
        });

    }];
}


- (void)setupUserOperationView{

    UILabel * cerCodeLabel = [[UILabel alloc]init];
    [cerCodeLabel setFrame:CGRectMake(20.0f, 100.0f, 80.0f, 40.0f)];
    [cerCodeLabel setBackgroundColor:[UIColor clearColor]];
    [cerCodeLabel setText:@"运行时间"];
    [cerCodeLabel setFont:[UIFont systemFontOfSize:16.0]];
    [cerCodeLabel setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:cerCodeLabel];
    
    
    UITextField *timeTextField = [[UITextField alloc]init];
    [timeTextField setTextAlignment:NSTextAlignmentLeft];
    [timeTextField setDelegate:self];
    [timeTextField setBackgroundColor:HUIRGBColor(245.0f, 245.0f, 245.0f, 1.0f)];
    [timeTextField setKeyboardType:UIKeyboardTypePhonePad];
    [timeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [timeTextField setFont:[UIFont systemFontOfSize:22.0f]];
    [timeTextField setTextColor:HUIRGBColor(45.0f, 45.0f, 45.0f, 1.0f)];
    [timeTextField setFrame:CGRectMake(100.0f, 100.0f, 180.0f, 40.0f)];
    self.synchronizeTimeIntegerField = timeTextField;
    [self.view addSubview:self.synchronizeTimeIntegerField];
    
    if(LvYeFMShareSetting.synchronizeTimeIntervalInt > 0){
        [self.synchronizeTimeIntegerField setText:[NSString stringWithFormat:@"%d",LvYeFMShareSetting.synchronizeTimeIntervalInt]];
    }
    
    UILabel * tourIDLabel = [[UILabel alloc]init];
    [tourIDLabel setFrame:CGRectMake(20.0f,160, 80.0f, 40.0f)];
    [tourIDLabel setBackgroundColor:[UIColor clearColor]];
    [tourIDLabel setText:@"开始ID"];
    [tourIDLabel setFont:[UIFont systemFontOfSize:16.0]];
    [tourIDLabel setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:tourIDLabel];
    
    UITextField *tourIDTextField = [[UITextField alloc]init];
    [tourIDTextField setTextAlignment:NSTextAlignmentLeft];
    [tourIDTextField setDelegate:self];
    [tourIDTextField setBackgroundColor:HUIRGBColor(245.0f, 245.0f, 245.0f, 1.0f)];
    [tourIDTextField setFrame:CGRectMake(100.0f, 160.0f, 180.0f, 40.0f)];
    [timeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [tourIDTextField setTextColor:HUIRGBColor(45.0f, 45.0f, 45.0f, 1.0f)];
    [tourIDTextField setFont:[UIFont systemFontOfSize:22.0f]];
    [tourIDTextField setKeyboardType:UIKeyboardTypePhonePad];
    self.synchronizeTourIDField = tourIDTextField;
    [self.view addSubview:self.synchronizeTourIDField];
    
    if (!IsStringEmptyOrNull(LvYeFMShareSetting.synchronizeProductIdStr) ){
        [self.synchronizeTourIDField setText:LvYeFMShareSetting.synchronizeProductIdStr];
    }
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setFrame:CGRectMake(295.0f, 100.0f, 60.0f, 100.0f)];
    [doneButton setBackgroundImage:createImageWithColor(HUIRGBColor(245.0f, 245.0f, 245.0f, 1.0f))
                          forState:UIControlStateNormal];
    [doneButton setBackgroundImage:createImageWithColor(HUIRGBColor(205.0f, 205.0f, 205.0f, 1.0f))
                          forState:UIControlStateHighlighted];
    [doneButton setTag:KBtnForDoneBeginTag];
    [doneButton setTitleColor:HUIRGBColor(45.0f, 45.0f, 45.0f, 1.0f) forState:UIControlStateNormal];
    [doneButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [doneButton setTitle:@"开始同步" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneAnsy:) forControlEvents:UIControlEventTouchUpInside];
    self.doneSynchronizeButton = doneButton;
    [self.view addSubview:self.doneSynchronizeButton];

    UITextView *logContentField = [[UITextView alloc]init];
    [logContentField setTextAlignment:NSTextAlignmentLeft];
    [logContentField setBackgroundColor:HUIRGBColor(245.0f, 245.0f, 245.0f, 1.0f)];
    [logContentField setFrame:CGRectMake(20.0f, 220, 300.0f, 120.0f)];
    [logContentField setTextColor:HUIRGBColor(45.0f, 45.0f, 45.0f, 1.0f)];
    [logContentField setFont:[UIFont systemFontOfSize:13.0f]];

    
    
    self.logContentTextField = logContentField;
    [self.view addSubview:self.logContentTextField];
    
    if (!IsStringEmptyOrNull(LvYeFMShareSetting.synchronizeLogsStr) ){
        [self.logContentTextField setText:LvYeFMShareSetting.synchronizeLogsStr];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)doneAnsy:(UIButton *)button{

    
    if(button.tag == KBtnForDoneBeginTag){
        int timeInteger = [self.synchronizeTimeIntegerField.text intValue];
        self.currentSec=timeInteger;
        
        
        
        [self.doneSynchronizeButton setTitle:@"同步中." forState:UIControlStateNormal];
        [self.doneSynchronizeButton  setTag:KBtnForDoneSynchronizeTag];
        
        ///本次同步,,同步到 S1104410...同步时间:2017-09-18 16:09:31
        self.productTourId = [self.synchronizeTourIDField.text intValue];
        
        
        [LvYeFMShareSetting setSynchronizeProductIdStr:self.synchronizeTourIDField.text];
        [LvYeFMShareSetting setSynchronizeTimeIntervalInt:timeInteger];
        
        self.timer=[NSTimer scheduledTimerWithTimeInterval:1.4f target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

        
        
    }else if (KBtnForDoneSynchronizeTag == button.tag ){
        NSString *logsString = self.logContentTextField.text;
        logsString=[NSString stringWithFormat:@"%@\n%@",@"正在同步",logsString];
        [self.logContentTextField setText:logsString];
    }
    
}

- (void)timeChange
{
    self.currentSec--;
    if (self.currentSec<=0) {
        NSLog(@"运行结束了...时间结束")
        [self.doneSynchronizeButton  setTag:KBtnForDoneBeginTag];
        [self.doneSynchronizeButton setTitle:@"开始同步" forState:UIControlStateNormal];
        NSString *logStr = [NSString stringWithFormat:@"%@ \n eventId is %@",@"运行结束了...时间结束",self.logContentTextField.text];
        [self.logContentTextField setText:logStr];
        [self.logContentTextField beginningOfDocument];
        [self.timer invalidate];
    }else{
        if (self.currentSec%2 == 0) {
            self.productTourId +=1;
            NSString *prodcutId = [NSString stringWithFormat:@"%i",self.productTourId];
           
            __weak __typeof(&*self)weakSelf = self;
            [FMHTTPClientSynchronizeAPI autoSysS1TourProductInforWithProductId:prodcutId completion:^(WebAPIResponse *response) {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    if (response.code == WebAPIResponseCodeSuccessForHundred) {
                        NSDictionary  *responeDic = ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                        if (responeDic.count > 0) {
                            
                            
                            NSString * currentLogs = StringForKeyInUnserializedJSONDic(responeDic, @"eventId");
                            NSString *logStr = [NSString stringWithFormat:@" eventId is  %@ \n %@",currentLogs,self.logContentTextField.text];
                            [weakSelf.logContentTextField setText:logStr];
                            
                            [LvYeFMShareSetting setSynchronizeLogsStr:weakSelf.logContentTextField.text];
                            
//                            [weakSelf.logContentTextField beginningOfDocument];
                            ///将数据本地化处理
                            NSLog(@"eventId is %@",StringForKeyInUnserializedJSONDic(responeDic, @"eventId"));
                        }
                    }else{
                        NSLog("同步失败的是: id --> %@",prodcutId );
                        
                        NSString *logStr = [NSString stringWithFormat:@"%@ \n 同步失败的是: id --> %@",prodcutId,self.logContentTextField.text];
                        [weakSelf.logContentTextField setText:logStr];
                        [weakSelf.logContentTextField beginningOfDocument];
                    }
                });
            }];
            
            
        }
    }
}


@end
