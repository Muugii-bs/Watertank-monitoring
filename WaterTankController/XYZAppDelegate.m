//
//  XYZAppDelegate.m
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/05/27.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import "XYZAppDelegate.h"
#import "XYZCommunicator.h"
#import "Globals.h"

#define er "ERROR"
#define keyXbee "RX62AP"

@implementation XYZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
//******************************************************************* Fetch saved log data ************************************************************************
    
        helpLogKey = [[NSMutableArray alloc] init];
        helpLogDetail = [[NSMutableArray alloc] init];
        helpLogIndex = [[NSMutableArray alloc] init];
    
        alarmLogDate = [[NSMutableArray alloc] init];
        alarmLogDescription = [[NSMutableArray alloc] init];
        alarmLogDetail = [[NSMutableArray alloc] init];
    
        textArray = [[NSMutableArray alloc] init];
    
        for (int i = 0; i < 10; i++) {
            NSString *tmp = [[NSString alloc ]initWithFormat:@"ヘルプ項目%d",i];
            [helpLogKey insertObject:tmp atIndex:i];
            NSString *tmp1 = [[NSString alloc ]initWithFormat:@"説明 -------------------- %d",i];
            [helpLogDetail insertObject:tmp1 atIndex:i];
            NSString *tmp2 = [[NSString alloc] initWithFormat:@"ユーザ%d",i];
            [helpLogIndex insertObject:tmp2 atIndex:i];
            
            NSString *tmp3 = [[NSString alloc ]initWithFormat:@"2014/7/%d",i];
            [alarmLogDate insertObject:tmp3 atIndex:i];
            NSString *tmp4 = [[NSString alloc ]initWithFormat:@"発生項目%d",i];
            [alarmLogDetail insertObject:tmp4 atIndex:i];
            NSString *tmp5 = [[NSString alloc] initWithFormat:@"議事録-------- %d",i];
            [alarmLogDescription insertObject:tmp5 atIndex:i];
            
            [textArray insertObject:tmp3 atIndex:i];
        }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    textArray1 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"KEY_TEST"]];  //test array
    changeLogFilter1 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"CHANGE_LOG_F1"]];
    changeLogFilter2 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"CHANGE_LOG_F2"]];
    
//******************************************************************* Get saved help data ************************************************************************
    
    return YES;

}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    /*[[XYZCommunicator commonCommunicator] close];*/

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //[[XYZCommunicator commonCommunicator] close];
    
    [self saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    /*if ([self wificonnection]) {
        
        [XYZCommunicator commonCommunicator]->host = @"http://192.168.1.10";
        
        [XYZCommunicator commonCommunicator]->port = 15000;
        
        [[XYZCommunicator commonCommunicator] setup];
        
        [[XYZCommunicator commonCommunicator] open];
        
        [self tcpConnectionRunLoop];
        
    }*/

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if ([self wificonnection]) {
        
        [XYZCommunicator commonCommunicator]->host = @"http://192.168.1.10";
        
        [XYZCommunicator commonCommunicator]->port = 15000;
        
        [[XYZCommunicator commonCommunicator] setup];
        
        [[XYZCommunicator commonCommunicator] open];
        
        bufferCounter = 0;
        
        NSLog(@"bufferCounter initialized %d\n",bufferCounter);
        
        bufferJunLevel = [[NSMutableArray alloc] initWithCapacity:7];
        bufferIeLevel = [[NSMutableArray alloc] initWithCapacity:7];
        bufferRoLevel = [[NSMutableArray alloc] initWithCapacity:7];
        
        for (int i=0; i<7; i++) {
            [bufferJunLevel insertObject:@0.0 atIndex:0];
            [bufferIeLevel insertObject:@0.0 atIndex:0];
            [bufferRoLevel insertObject:@0.0 atIndex:0];
        }
        
        [self tcpConnectionRunLoop];
        
    }

    /*for (int i=0; i<10; i++){
        NSString *msg = [[NSString alloc] initWithFormat:@"Log no%d",i];
        [changeLogFilter1 addObject:msg];
        [changeLogFilter2 addObject:msg];
        NSLog(@"object added changeLogFilter1:%@ \n",changeLogFilter1[i]);
    }*/

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    textArray1 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"KEY_TEST"]];  // KEY_Iの内容をint型として取得
    changeLogFilter1 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"CHANGE_LOG_F1"]];
    changeLogFilter2 = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"CHANGE_LOG_F2"]];
    alarmLogDetail = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"ALARM_LOG_DETAIL"]];
    alarmLogDate = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"ALARM_LOG_DATE"]];
    alarmLogDescription = [[NSMutableArray alloc] initWithArray:[ud arrayForKey:@"ALARM_LOG_DESCRIPTION"]];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[XYZCommunicator commonCommunicator] close];
    [[XYZCommunicator commonCommunicator] release];
    
    [NSThread exit];
    NSLog(@"thread is stopped\n");
    
    [self saveData];
}

//******************************************************************* Save help file  ************************************************************************

- (void) saveData {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // saving data into the device
    [ud setObject:textArray forKey:@"KEY_TEST"];
    [ud setObject:changeLogFilter1 forKey:@"CHANGE_LOG_F1"];
    [ud setObject:changeLogFilter2 forKey:@"CHANGE_LOG_F2"];
    [ud setObject:alarmLogDate forKey:@"ALARM_LOG_DATE"];
    [ud setObject:alarmLogDescription forKey:@"ALARM_LOG_DESCRIPTION"];
    [ud setObject:alarmLogDetail forKey:@"ALARM_LOG_DETAIL"];
    
    BOOL successful = [ud synchronize];
    if (successful) {
        NSLog(@"test data saved\n");
    }
    else NSLog(@"error in saving data\n");
}

//******************************************************************* Wi-fi network check ************************************************************************


-(int)wificonnection {
    
    int flag = 0;
    
    CFArrayRef myArray = CNCopySupportedInterfaces();
    
    NSDictionary* myDictionary = (NSDictionary *) CFBridgingRelease(CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0)));
    
    if (myDictionary) {
        
        hostSSID = [myDictionary valueForKey:@"SSID"];
    }
    
    else if (!myDictionary) {
        
        hostSSID = @er;
    }
    NSLog(@"%@\n",hostSSID);
    
    hostAddress = [self getIPAddress];
    
    NSLog(@"%@\n",hostAddress);
    
    if ([hostSSID  isEqual: @er]) {
        
        NSString *alertMsg = @"接続エラー！";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(alertMsg, @"AlertView")message:NSLocalizedString(@"ネットワークに接続されていません", @"AlertView") delegate: nil cancelButtonTitle:NSLocalizedString(@"確認",@"AlertView") otherButtonTitles: nil, nil];
        [alertView show];
        openCloseFlg = false;
        return 0;
        
    }
    
    else if (![hostSSID hasPrefix:@keyXbee]){
        
        NSString *alertMsg = @"不適切なネットワーク!";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(alertMsg, @"AlertView")message:NSLocalizedString(@"正確なネットワークに接続してください",@"alertView") delegate:self cancelButtonTitle:NSLocalizedString(@"確認", @"AlertView") otherButtonTitles:nil, nil];
        [alertView show];
        openCloseFlg = false;
        return 0;
    }
    
    else if ([hostSSID hasPrefix:@keyXbee]){
        
        NSString *alertMsg = @"水タンク接続に成功しました";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(alertMsg, @"alertView")message:NSLocalizedString(@"モニタリングに進んで下さい", @"alertView") delegate:self cancelButtonTitle:NSLocalizedString(@"確認", @"AlertView") otherButtonTitles:nil, nil];
        
        [alertView show];
        openCloseFlg = true;
        
        flag = 1;
    }
    return flag;
}

//******************************************************************* Get own ip address ************************************************************************

- (NSString *)getIPAddress

{
    NSString *address = @"error";
    NSString *hostName = @"http://";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    hostName = [hostName stringByAppendingString:address];
    
    return address;
}

//*******************************************************************************************************************************************************************

- (void)tcpConnectionRunLoop
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(fetchData) object:nil];
    
    //[self performSelector:@selector(receiveData) onThread:thread withObject:nil waitUntilDone:YES];
    
    [thread start];
    
    //[self performSelector:@selector(receiveData) onThread:thread withObject:nil waitUntilDone:YES];
}

//- (void)hello
//{
//    NSLog(@"hello on the countDown thread!!!");
//}

- (void)fetchData
{
    if ([[XYZCommunicator commonCommunicator] isOpened])while (1) {
        
        [[XYZCommunicator commonCommunicator] writeOut:@"w<>"];
        
        NSLog(@"msg: w<> has sent \n");
        NSLog(@"msg has received %@\n",readMsg);
        
        //[NSThread sleepForTimeInterval:1];
        
        if (readMsg) {
        
        CGFloat fl0 = [[[self getMsg] objectAtIndex:2] floatValue] + [[[self getMsg] objectAtIndex:4] floatValue]* 0.1;
            
            NSNumber *fl00 = [NSNumber numberWithFloat:fl0];
        
        [bufferRoLevel insertObject:fl00 atIndex:0];
            
        CGFloat fl1 = [[[self getMsg] objectAtIndex:5] floatValue] + [[[self getMsg] objectAtIndex:7] floatValue]* 0.1;
            
            NSNumber *fl11 = [NSNumber numberWithFloat:fl1];
        
        [bufferIeLevel insertObject:fl11 atIndex:0];
        
        CGFloat fl2 = [[[self getMsg] objectAtIndex:8] floatValue] + [[[self getMsg] objectAtIndex:10] floatValue]* 0.1;
            
            NSNumber *fl22 = [NSNumber numberWithFloat:fl2];

            
        [bufferJunLevel insertObject:fl22 atIndex:0];
            
        NSLog(@"%@ %@ %@ \n",[bufferRoLevel objectAtIndex:bufferCounter % 7],[bufferIeLevel objectAtIndex:bufferCounter % 7],[bufferJunLevel objectAtIndex:bufferCounter % 7]);
        
        bufferCounter ++;
        
        NSLog(@"bufferCounter = %d\n",bufferCounter);

        }
        
        [NSThread sleepForTimeInterval:2];

    }
    
    else {

    [XYZCommunicator commonCommunicator]->host = @"http://192.168.1.10";
    
    [XYZCommunicator commonCommunicator]->port = 15000;
    
    [[XYZCommunicator commonCommunicator] setup];
    
    [[XYZCommunicator commonCommunicator] open];
    
    [self fetchData];
    
    }
    
}

- (NSArray *)convertToArray: (NSString *)string {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < string.length; i ++) {
        [array addObject:[NSString stringWithFormat:@"%c", [string characterAtIndex:i]]];
    }
    
    return array;
}

- (NSArray *)getMsg {
    return [self convertToArray:readMsg];
}


@end
