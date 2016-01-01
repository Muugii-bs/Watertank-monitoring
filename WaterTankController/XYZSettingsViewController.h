//
//  XYZSettingsViewController.h
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/07/26.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h" 

@interface XYZSettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *timerSelect;
@property (weak, nonatomic) IBOutlet UITextField *warningRO;
@property (weak, nonatomic) IBOutlet UITextField *warningIE;
@property (weak, nonatomic) IBOutlet UITextField *warningCycle;
@property (weak, nonatomic) IBOutlet UITextField *alarmRO;
@property (weak, nonatomic) IBOutlet UITextField *alarmIE;
@property (weak, nonatomic) IBOutlet UITextField *alarmCycle;
@property (weak, nonatomic) IBOutlet UILabel *errorMsg;
- (BOOL)valueChecker:(NSString *)text;
@end
