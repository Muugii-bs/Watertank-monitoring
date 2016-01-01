//
//  XYZCommunicator.h
//  XbeeConnection
//
//  Created by MACmachineHitechlab on 2014/05/13.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Globals.h"
#import "XYZViewController.h"
#import "XYZMonitorViewController.h"

//@interface viewController : XYZViewController;
//@end


@interface XYZCommunicator : NSObject <NSStreamDelegate> {
@public
	
	NSString *host;
	int port;
    NSMutableArray *msg;
    BOOL connectionFlg;
}
@property (nonatomic, unsafe_unretained) char* frameType;
@property (nonatomic, unsafe_unretained) double* value;
@property (nonatomic, unsafe_unretained) double *ro;
@property (nonatomic, unsafe_unretained) double *ie;
@property (nonatomic, unsafe_unretained) double *level;
@property (nonatomic, unsafe_unretained) NSMutableArray *levelLog;
@property (nonatomic, unsafe_unretained) NSMutableArray *ieLog;
@property (nonatomic, unsafe_unretained) NSMutableArray *roLog;

+ (XYZCommunicator *)commonCommunicator;
- (void)setup;
- (void)open;
- (void)close;
- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event;
- (void)readIn:(NSString *)s;
- (void)writeOut:(NSString *)s;
- (BOOL)isOpened;

//- (NSMutableArray *)msgOut;

@end