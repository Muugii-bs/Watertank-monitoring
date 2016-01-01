//
//  XYZAppDelegate.h
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/05/27.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZCommunicator.h"
#import "SystemConfiguration/CaptiveNetwork.h"
#include "ifaddrs.h"
#include "arpa/inet.h"
#import "Globals.h"
#import <Foundation/Foundation.h>
#import "XYZMonitorViewController.h"

@class XYZMonitorViewController;

@interface XYZAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) XYZMonitorViewController *monitorViewController;

-(int)wificonnection;
- (NSString *)getIPAddress;
- (NSArray *)getMsg;

@end
