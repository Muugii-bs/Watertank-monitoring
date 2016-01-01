//
//  XYZSettingsViewController.m
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/07/26.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import "XYZSettingsViewController.h"

#define DEFAULT 5.0

@interface XYZSettingsViewController ()

@end

@implementation XYZSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[seg addTarget:self action:@selector(hoge:)forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)setTimer:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 hh時mm分"];
    NSString *dateString = [dateFormatter stringFromDate:self.datePicker.date];
    switch (self.timerSelect.selectedSegmentIndex) {
        case 0: globalTime[0] = [[NSString alloc] initWithString:dateString];
            break;
        case 1: globalTime[1] = [[NSString alloc] initWithString:dateString];
            break;
        case 2: globalTime[2] = [[NSString alloc] initWithString:dateString];
            break;
        default: break;
    }
    NSLog(@"%@ %@ %@\n",globalTime[0],globalTime[1],globalTime[2]);
}
- (IBAction)setLimitValues:(id)sender {
    if ([self valueChecker:self.warningRO.text]) {
        roLimitWarning = [self.warningRO.text doubleValue];
        self.warningRO.text = nil;
        self.errorMsg.text = nil;
    } else
    
    if ([self valueChecker:self.warningIE.text]) {
        ieLimitWarning = [self.warningIE.text doubleValue];
        self.warningIE.text = nil;
        self.errorMsg.text = nil;
    } else
    
    if ([self valueChecker:self.warningCycle.text]) {
        junkansuiLimitWarning = [self.warningCycle.text doubleValue];
        self.warningCycle.text = nil;
        self.errorMsg.text = nil;
    } else
    
    if ([self valueChecker:self.alarmRO.text]) {
        roLimitAlarm = [self.alarmRO.text doubleValue];
        self.alarmRO.text = nil;
        self.errorMsg.text = nil;
    } else
    
    if ([self valueChecker:self.alarmIE.text]) {
        ieLImitAlarm = [self.alarmIE.text doubleValue];
        self.alarmIE.text = nil;
        self.errorMsg.text = nil;
    } else
    
    if ([self valueChecker:self.alarmCycle.text]) {
        junkansuiLimitAlarm = [self.alarmCycle.text doubleValue];
        self.alarmCycle.text = nil;
        self.errorMsg.text = nil;
    } else self.errorMsg.text = @"値が入力されていないあるいは、不正な値が入力されています！";
    
    NSLog(@"%lf %lf %lf %lf %lf %lf\n",roLimitWarning,ieLimitWarning,junkansuiLimitWarning,roLimitAlarm,ieLImitAlarm,junkansuiLimitAlarm);
}

- (BOOL)valueChecker:(NSString *)text {
    if (text != nil &&  [text doubleValue] > 0.0 && [text doubleValue] < 1000000.0) {
    	return true;
    }
    else return false;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
