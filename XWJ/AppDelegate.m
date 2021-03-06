//
//  AppDelegate.m
//  信我家
//
//  Created by Paul on 9/11/15.
//  Copyright (c) 2015年 Paul. All rights reserved.
//

#import "AppDelegate.h"
#import "XWJdef.h"
#import "AFNetworking.h"
#import "XWJAccount.h"
#import "XWJTabViewController.h"
////腾讯开放平台（对应QQ和QQ空间）SDK头文件
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//
////微信SDK头文件
//#import "WXApi.h

#import <SMS_SDK/SMSSDK.h>
#import "XWJCity.h"
#define mobAppKey @"c647ba762dc0"
#define mobAppSecret @"76e6d7422f5d958e9a882675d0ffbd29"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [SMSSDK registerApp:mobAppKey withSecret:mobAppSecret];
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
//    [ShareSDK registerApp:@"iosv1101"
//     
//          activePlatforms:@[
//                            @(SSDKPlatformTypeSinaWeibo),
//                            @(SSDKPlatformTypeMail),
//                            @(SSDKPlatformTypeSMS),
//                            @(SSDKPlatformTypeCopy),
//                            @(SSDKPlatformTypeWechat),
//                            @(SSDKPlatformTypeQQ),
//                            @(SSDKPlatformTypeRenren),
//                            @(SSDKPlatformTypeGooglePlus)]
//                 onImport:^(SSDKPlatformType platformType)
//     {
//         switch (platformType)
//         {
//             case SSDKPlatformTypeWechat:
//                 [ShareSDKConnector connectWeChat:[WXApi class]];
//                 break;
//             case SSDKPlatformTypeQQ:
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                 break;
//             case SSDKPlatformTypeSinaWeibo:
//                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                 break;
//             case SSDKPlatformTypeRenren:
//                 [ShareSDKConnector connectRenren:[RennClient class]];
//                 break;
//             case SSDKPlatformTypeGooglePlus:
//                 [ShareSDKConnector connectGooglePlus:[GPPSignIn class]
//                                           shareClass:[GPPShare class]];
//                 break;
//             default:
//                 break;
//         }
//     }
//          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
//     {
//         
//         switch (platformType)
//         {
//             case SSDKPlatformTypeSinaWeibo:
//                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                                         redirectUri:@"http://www.sharesdk.cn"
//                                            authType:SSDKAuthTypeBoth];
//                 break;
//             case SSDKPlatformTypeWechat:
//                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
//                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
//                 break;
//             case SSDKPlatformTypeQQ:
//                 [appInfo SSDKSetupQQByAppId:@"100371282"
//                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
//                                    authType:SSDKAuthTypeBoth];
//                 break;
//             case SSDKPlatformTypeRenren:
//                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
//                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
//                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
//                                               authType:SSDKAuthTypeBoth];
//                 break;
//             case SSDKPlatformTypeGooglePlus:
//                 [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
//                                           clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
//                                            redirectUri:@"http://localhost"
//                                               authType:SSDKAuthTypeBoth];
//                 break;
//             default:
//                 break;
//         }
//     }];
    
//    __strong NSMutableArray *arr = [NSMutableArray array];

//    [self getCity];
//
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    NSString *uname = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    NSString *pass = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];

    if (uname&&pass) {
        [self loginUname:uname Pwd:pass];
    }else{
        [self toLoginController];
        
    }
    
//    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"XWJLoginStoryboard" bundle:nil];
//    self.window.rootViewController = [loginStoryboard instantiateViewControllerWithIdentifier:@"bindhouse2"];
    
    
    return YES;
}

-(void)loginUname:(NSString *)username Pwd:(NSString *)pwd{
    if (username.length>0&&pwd.length>0) {
        
        //        NSString *url = @"http://www.hisenseplus.com:8100/appPhone/rest/user/userLogin";
        NSString *url = LOGIN_URL;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:username forKey:@"account"];
        [dict setValue:pwd forKey:@"password"];
        
        
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSNumber * result = [dic valueForKey:@"result"];
            if ([result intValue]== 1) {
            
                NSDictionary *userDic = [[dic objectForKey:@"data"] objectForKey:@"user"];
                NSString *sid = [userDic valueForKey:@"id"];
                NSLog(@"sid %@",sid);
                [XWJAccount instance].uid = sid;
                [XWJAccount instance].account = [userDic valueForKey:@"Account"];
                [XWJAccount instance].password = pwd;
                [XWJAccount instance].NickName =[userDic valueForKey:@"NickName"];
                [XWJAccount instance].name = [userDic valueForKey:@"NAME"];
                [XWJAccount instance].Sex = [userDic valueForKey:@"sex"];
                [XWJAccount instance].phone = [userDic valueForKey:@"TEL"];
                /*
                 "A_id" = 4;
                 "A_name" = "\U9ea6\U5c9b\U91d1\U5cb8";
                 isDefault = 1;
                 */
                [XWJAccount instance].array = [[dic objectForKey:@"data"] valueForKey:@"area"];
                if ([XWJAccount instance].array&&[XWJAccount instance].array.count>0) {
                    for (NSDictionary *di in [XWJAccount instance].array ) {
                        if ([[di valueForKey:@"isDefault" ] integerValue]== 1) {
                            [XWJAccount instance].aid = [NSString stringWithFormat:@"%@",[di valueForKey:@"A_id"]];
                        }
                    }
                }
                
                BOOL isBind = [XWJAccount instance].aid?TRUE:FALSE;
                if (!isBind) {
                    
                    UIStoryboard * login = [UIStoryboard storyboardWithName:@"XWJLoginStoryboard" bundle:nil];
                    UIViewController *view =[login instantiateViewControllerWithIdentifier:@"xuanzefangshi"];
                    
                    UINavigationController *nav = [[UINavigationController alloc] init];
                    [nav showViewController:view sender:nil];
                    self.window.rootViewController = nav;
                    
                    //                    XWJBindHouseTableViewController *bind = [[XWJBindHouseTableViewController alloc] init];
                    //                    bind.title = @"城市选择";
                    //                    bind.delegate = self;
                    //                    bind->mode = HouseCity;
                    //                    [self.navigationController showViewController:bind sender:nil];
                }else{
                    
                    XWJTabViewController *tab = [[XWJTabViewController alloc] init];
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    window.rootViewController = tab;
                }
            }else{
                [self toLoginController];

            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"log fail ");
            //        dispatch_async(dispatch_get_main_queue(), ^{
            //            XWJTabViewController *tab = [[XWJTabViewController alloc] init];
            //            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            //            window.rootViewController = tab;            //        });
            
            [self toLoginController];

        }];
    }
    
    /*
     XWJBindHouseTableViewController *bind = [[XWJBindHouseTableViewController alloc] init];
     bind.title = @"城市选择";
     bind.dataSource = [NSArray arrayWithObjects:@"青岛市",@"济南市",@"威海市", nil];
     bind.delegate = self;
     bind->mode = HouseCity;
     [self.navigationController showViewController:bind sender:nil];
     */
}

-(void)toLoginController{
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"XWJLoginStoryboard" bundle:nil];
    self.window.rootViewController = [loginStoryboard instantiateInitialViewController];

}
-(void)getCity{
    
    NSString *url = GETCITY_URL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%s success ",__FUNCTION__);
        
        if(responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            
//            NSMutableArray * array = [NSMutableArray array];
//            XWJCity *city  = [[XWJCity alloc] init];
            
            NSArray *arr  = [dic objectForKey:@"data"];
            for (NSDictionary *d in arr) {
                NSLog(@"dic %@",d);
            }
            
            
            NSLog(@"dic %@",dic);
        }
        //        XWJTabViewController *tab = [[XWJTabViewController alloc] init];
        //        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //        window.rootViewController = tab;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s fail ",__FUNCTION__);
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //        XWJTabViewController *tab = [[XWJTabViewController alloc] init];
        //        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //        window.rootViewController = tab;            //        });
    }];
}

-(BOOL)checkAutoLogin{

    return FALSE;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
