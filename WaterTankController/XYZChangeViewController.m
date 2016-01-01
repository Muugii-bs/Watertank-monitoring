//
//  XYZChangeViewController.m
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/06/21.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import "XYZChangeViewController.h"
#import "XYZChangeLogViewController.h"

#define sw1 1
#define sw2 2
#define sw3 3
#define swGrp1 1
#define swGrp2 2
#define ON 1
#define OFF 0

@interface XYZChangeViewController () {
    NSInteger statusGrpOneSw1;
    NSInteger statusGrpOneSw2;
    NSInteger statusGrpOneSw3;
    NSInteger statusGrpTwoSw1;
    NSInteger statusGrpTwoSw2;
    NSInteger groupOfSwitch;
    NSInteger count;
    
    NSNotification *n1;
    NSNotification *n2;
}

@end

@implementation XYZChangeViewController

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
    [_switchOne1 addTarget:self action:@selector(switchOne1event:)forControlEvents:UIControlEventValueChanged];
    [_switchOne2 addTarget:self action:@selector(switchOne2event:)forControlEvents:UIControlEventValueChanged];
    [_switchOne3 addTarget:self action:@selector(switchOne3event:)forControlEvents:UIControlEventValueChanged];
    [_switchTwo1 addTarget:self action:@selector(switchTwo1event:)forControlEvents:UIControlEventValueChanged];
    [_switchTwo2 addTarget:self action:@selector(switchTwo2event:)forControlEvents:UIControlEventValueChanged];
    
    n1 = [NSNotification notificationWithName:@"groupOneStopped" object:self];
    n2 = [NSNotification notificationWithName:@"groupTwoStopped" object:self];

    //------------------------------------------ Notification center routine ---------------------------------
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)switchOne1event:(UISwitch *)swithch {
    if (groupOfSwitch != swGrp1) groupOfSwitch = swGrp1;
    if (self.switchOne1.on == YES) statusGrpOneSw1 = ON;
    else statusGrpOneSw1 = OFF;
    NSLog(@"switch one's status: %ld\n\n",(long)statusGrpOneSw1);
}
-(void)switchOne2event:(UISwitch *)swithch {
    if (groupOfSwitch != swGrp1) groupOfSwitch = swGrp1;
    if (self.switchOne2.on == YES) statusGrpOneSw2 = ON;
    else statusGrpOneSw2 = OFF;
    NSLog(@"switch two's status: %ld\n\n",(long)statusGrpOneSw2);
}
-(void)switchOne3event:(UISwitch *)swithch {
    if (groupOfSwitch != swGrp1) groupOfSwitch = swGrp1;
    if (self.switchOne3.on == YES) statusGrpOneSw3 = ON;
    else statusGrpOneSw3 = OFF;
    NSLog(@"switch three's status: %ld\n\n",(long)statusGrpOneSw3);
}
-(void)switchTwo1event:(UISwitch *)swithch {
    if (groupOfSwitch != swGrp2) groupOfSwitch = swGrp2;
    if (self.switchTwo1.on == YES) statusGrpTwoSw1 = ON;
    else statusGrpTwoSw1 = OFF;
    NSLog(@"switch four's status: %ld\n\n",(long)statusGrpTwoSw1);
}
-(void)switchTwo2event:(UISwitch *)swithch {
    if (groupOfSwitch != swGrp2) groupOfSwitch = swGrp2;
    if (self.switchTwo2.on == YES) statusGrpTwoSw2 = ON;
    else statusGrpTwoSw2 = OFF;
    NSLog(@"switch five's status: %ld\n\n",(long)statusGrpTwoSw2);
}
- (IBAction)groupOneStartButtonClicked:(id)sender {
    [self.switchOne1 setEnabled:NO];
    [self.switchOne2 setEnabled:NO];
    [self.switchOne3 setEnabled:NO];
    [self.startButton1 setEnabled:NO];
    
    NSDate *date1 = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日 HH時mm分";
    NSString *dateGrp1 = [dateFormatter stringFromDate:date1];
    [changeLogFilter1 addObject:dateGrp1];
    NSLog(@"date logged %ld %@\n\n",changeLogFilter1.count -1,[changeLogFilter1 objectAtIndex:count]);
    count ++;
}
- (IBAction)groupOneStopButtonClicked:(id)sender {
    [self.switchOne1 setEnabled:YES];
    [self.switchOne2 setEnabled:YES];
    [self.switchOne3 setEnabled:YES];
    [self.startButton1 setEnabled:YES];
    [[NSNotificationCenter defaultCenter] postNotification:n1];
}
- (IBAction)groupTwoStartButtonClicked:(id)sender {
    [self.switchTwo1 setEnabled:NO];
    [self.switchTwo2 setEnabled:NO];
    [self.startButton2 setEnabled:NO];
    
    NSDate *date2 = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日 HH時mm分";
    NSString *dateGrp2 = [dateFormatter stringFromDate:date2];
    [changeLogFilter2 addObject:dateGrp2];
    NSLog(@"date logged %@\n\n",dateGrp2);
}
- (IBAction)groupTwoStopButtonClicked:(id)sender {
    [self.switchTwo1 setEnabled:YES];
    [self.switchTwo2 setEnabled:YES];
    [self.startButton2 setEnabled:YES];
    [[NSNotificationCenter defaultCenter] postNotification:n2];
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
