//
//  XYZChangeViewController.h
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/06/21.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "XYZChangeLogViewController.h"

@interface XYZChangeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *display1;
@property (weak, nonatomic) IBOutlet UITextView *display2;
@property (weak, nonatomic) IBOutlet UISwitch *switchOne1;
@property (weak, nonatomic) IBOutlet UISwitch *switchOne2;
@property (weak, nonatomic) IBOutlet UISwitch *switchOne3;
@property (weak, nonatomic) IBOutlet UISwitch *switchTwo2;
@property (weak, nonatomic) IBOutlet UISwitch *switchTwo1;

@property (weak, nonatomic) IBOutlet UIButton *stopButton1;
@property (weak, nonatomic) IBOutlet UIButton *stopButton2;
@property (weak, nonatomic) IBOutlet UIButton *startButton1;
@property (weak, nonatomic) IBOutlet UIButton *startButton2;

@end
