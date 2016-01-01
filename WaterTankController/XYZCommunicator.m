//
//  XYZCommunicator.m
//  XbeeConnection
//
//  Created by MACmachineHitechlab on 2014/05/13.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import "XYZCommunicator.h"

CFReadStreamRef readStream;
CFWriteStreamRef writeStream;
NSInputStream *inputStream;
NSOutputStream *outputStream;

@implementation XYZCommunicator

+ (XYZCommunicator *)commonCommunicator {
    
    static XYZCommunicator *commonCommunicator;
    
    @synchronized(self)
    {
        if (!commonCommunicator)
            commonCommunicator = [[XYZCommunicator alloc] init];
        
        return commonCommunicator;
    }
}
    


//Establishing a socket

- (void)setup {
    
        _roLog = [NSMutableArray arrayWithCapacity:7];
        _ieLog = [NSMutableArray arrayWithCapacity:7];
        _levelLog = [NSMutableArray arrayWithCapacity:7];
    
   /* for (int i = 0; i < 7; i++) {
        [_roLog addObject:0];
        [_ieLog addObject:0];
        [_levelLog addObject:0];
    }*/
    
	NSURL *url = [NSURL URLWithString:host];
    
    NSLog(@"Setting up connection to %@ : %i", [url absoluteString], port);
	
	CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (CFStringRef)CFBridgingRetain([url host]), port, &readStream, &writeStream);
	
	if(!CFWriteStreamOpen(writeStream)) {
		NSLog(@"Error, writeStream not open");
        
		//[msg addObject:@"Error, writeStream not open"];
        
		return;
	}
    
	[self open];

    
	NSLog(@"Status of outputStream: %lu", [outputStream streamStatus]);
    
	return;
}

- (void)open {
    
	NSLog(@"Opening streams.");
	//[msg addObject:@"Openning streams."];
    
	inputStream = (NSInputStream *)CFBridgingRelease(readStream);
	outputStream = (NSOutputStream *)CFBridgingRelease(writeStream);
	
	[inputStream retain];
	[outputStream retain];
	
	[inputStream setDelegate:self];
	[outputStream setDelegate:self];
	
	[inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	
	[inputStream open];
	[outputStream open];
    
    connectionFlg = true;
}

- (void)close {
    
	NSLog(@"Closing streams.");
	//[msg addObject:@"Closing streams."];
    
	[inputStream close];
	[outputStream close];
	
	[inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	
	[inputStream setDelegate:nil];
	[outputStream setDelegate:nil];
	
	[inputStream release];
	[outputStream release];
	
	inputStream = nil;
	outputStream = nil;
    
    connectionFlg = false;
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event {
    
    NSLog(@"Stream handler activated.");
	//[msg addObject:@"Stream triggered."];
    
	switch(event) {
		case NSStreamEventHasSpaceAvailable: {
			if(stream == outputStream) {
				//NSLog(@"outputStream is ready.");
                [msg addObject:@"outputStream is ready."];
                
			}
			break;
		}
		case NSStreamEventHasBytesAvailable: {
			if(stream == inputStream) {
				NSLog(@"inputStream is ready.");
				//[msg addObject:@"inputStream is ready."];
                
				uint8_t buf[1024];
				long len = 0;
				
				len = [inputStream read:buf maxLength:1024];
				
				if(len > 0) {
                    
                    
					NSMutableData* data=[[NSMutableData alloc] initWithLength:0];
					
					[data appendBytes: (const void *)buf length:len];
					
					NSString *s = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
					
					[self readIn:s];
					
                    [data release];
                    
                    [s release];
                    
				}
			}
			break;
		}
		default: {
			NSLog(@"Stream is sending an Event: %lu", event);
            
			break;
		}
	}
}

- (void)readIn:(NSString *)s {
    
	//NSLog(@"Reading in the following:");
	//NSLog(@"%@", s);
    
    readMsg = [[NSString alloc] initWithString:s];
    // [viewController displayMsg];
    
    readFlg = 1;
    
    //NSLog(@"ReadMsg = %@\n",readMsg);
    //[msg addObject:@"Reading in the following:"];
    //[msg addObject:s];
}

- (void)writeOut:(NSString *)s {
	uint8_t *buf = (uint8_t *)[s UTF8String];
	
	[outputStream write:buf maxLength:strlen((char *)buf)];
	
	//NSLog(@"Writing out the following:");
	//NSLog(@"%@", s);
    
    //[msg addObject:@"Writing out the following:"];
    //[msg addObject:s];
}

- (BOOL)isOpened {
    return connectionFlg & openCloseFlg;
}

/*
 - (NSMutableArray *)msgOut {
 
 return self->msg;
 }
 */

@end
