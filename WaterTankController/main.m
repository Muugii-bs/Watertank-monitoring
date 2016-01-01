//
//  main.m
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/05/27.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZCommunicator.h"
#import "XYZAppDelegate.h"

BOOL openCloseFlg;

NSMutableArray *ro;
NSMutableArray *timeSynch;

NSMutableArray *textArray;
NSMutableArray *textArray1;

int bufferCounter;
NSMutableArray *bufferRoLevel;
NSMutableArray *bufferIeLevel;
NSMutableArray *bufferJunLevel;

NSString *readMsg;
unsigned int readFlg = 0;
NSString *hostSSID;
NSString *hostAddress;

NSMutableArray *alarmLogDate;
NSMutableArray *alarmLogDetail;
NSMutableArray *alarmLogDescription;

NSMutableArray *helpLogKey;
NSMutableArray *helpLogDetail;
NSMutableArray *helpLogIndex;

NSMutableArray *changeLogFilter1;
NSMutableArray *changeLogFilter2;

double roLimitWarning;
double ieLimitWarning;
double junkansuiLimitWarning;
double roLimitAlarm;
double ieLImitAlarm;
double junkansuiLimitAlarm;

NSString *globalTime[3];

//extern XYZData *data;
//extern XYZCommunicator *tcpSocket;

int main(int argc, char * argv[])
{
        @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([XYZAppDelegate class]));
    }
}
