//
//  XYZChangeLogViewController.h
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/07/22.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"

@interface XYZChangeLogViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textViewer1;
@property (weak, nonatomic) IBOutlet UITextView *textViewer2;

//+ (XYZChangeLogViewController *)commonChangeLog;
- (void)viewLogMessages;
@end
