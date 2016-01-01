//
//  XYZMonitorViewController.h
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/06/21.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChartDelegate.h"
#import "PNChart.h"
#import "XYZCommunicator.h"
#import "Globals.h"

@interface XYZMonitorViewController : UIViewController<PNChartDelegate>

@property (weak, nonatomic) IBOutlet UILabel *alarmLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIcon;

@property (weak, nonatomic) IBOutlet UILabel *ieView;
@property (weak, nonatomic) IBOutlet UILabel *roView;
@property (weak, nonatomic) IBOutlet UILabel *junkansuiView;
@property (weak, nonatomic) IBOutlet UILabel *moduleRunTimeNowView;
@property (weak, nonatomic) IBOutlet UILabel *moduleRunTimeExchangeView;
@property (weak, nonatomic) IBOutlet UILabel *kasseiTanFilterNowView;
@property (weak, nonatomic) IBOutlet UILabel *kasseiTanFilterExchangeView;
@property (weak, nonatomic) IBOutlet UILabel *uiLampTimeNowView;
@property (weak, nonatomic) IBOutlet UILabel *uiLampTimeExchangeView;

@property (nonatomic) PNBarChart * barChart;
@property (nonatomic) PNLineChart *lineChart;
@property (weak, nonatomic) UILabel *lineChartLabel;
@property (weak, nonatomic) UILabel *barChartLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *chartSwitch;
@property (weak, nonatomic) IBOutlet UIView *colorBoxRO;
@property (weak, nonatomic) IBOutlet UIView *colorBoxIE;
@property (weak, nonatomic) IBOutlet UIView *colorBoxJNS;
@property (weak, nonatomic) IBOutlet UILabel *graphLabelRO;
@property (weak, nonatomic) IBOutlet UILabel *graphLabelIE;
@property (weak, nonatomic) IBOutlet UILabel *graphLabelJNS;
@property (weak, nonatomic) IBOutlet UIView *colorBoxModule;
@property (weak, nonatomic) IBOutlet UIView *colorBoxKSfilter;
@property (weak, nonatomic) IBOutlet UIView *colorBoxUV;
@property (weak, nonatomic) IBOutlet UILabel *graphLabelModule;
@property (weak, nonatomic) IBOutlet UILabel *graphLabelKSfilter;
@property (weak, nonatomic) IBOutlet UILabel *graphLabelUV;

- (NSArray *)convertToArray :(NSString *)string;

- (void)printData : (NSTimer *)timer;

- (void)refreshChart : (NSTimer *)timer1;

@end
