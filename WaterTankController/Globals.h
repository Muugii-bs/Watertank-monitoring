//
//  NSObject_Globals.h
//  XbeeConnection
//
//  Created by MACmachineHitechlab on 2014/05/13.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//



#ifndef Globals_h
#define Globals_h

//********************************* Variables for level parameters *********************************

extern BOOL openCloseFlg;

extern NSMutableArray *ro;
extern NSMutableArray *timeSynch;

extern NSMutableArray *textArray;
extern NSMutableArray *textArray1;

extern int bufferCounter;
extern NSMutableArray *bufferRoLevel;
extern NSMutableArray *bufferIeLevel;
extern NSMutableArray *bufferJunLevel;


//********************************* Variables for TCP connection *********************************

extern NSString *readMsg;
extern unsigned int readFlg;

extern NSString *hostSSID;
extern NSString *hostAddress;

//********************************* Containers for alarm log *********************************

extern NSMutableArray *alarmLogDate;
extern NSMutableArray *alarmLogDetail;
extern NSMutableArray *alarmLogDescription;

//********************************* Container for help file *********************************

extern NSMutableArray *helpLogKey;
extern NSMutableArray *helpLogDetail;
extern NSMutableArray *helpLogIndex;

//********************************* Variables for monitoring view *********************************


extern double roLimitWarning;
extern double ieLimitWarning;
extern double junkansuiLimitWarning;
extern double roLimitAlarm;
extern double ieLImitAlarm;
extern double junkansuiLimitAlarm;

extern NSString *globalTime[3];

//********************************* Variables for change log *********************************

extern NSMutableArray *changeLogFilter1;
extern NSMutableArray *changeLogFilter2;

//extern XYZData *data;
//extern XYZCommunicator *tcpSocket;

//********************************* Packet types *********************************

#define request 'r'
#define err 'e'
#define response 'p'
#define order 'o'
#define monitor 'm'

//*******************************************************************************

#endif