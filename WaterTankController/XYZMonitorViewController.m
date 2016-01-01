//
//  XYZMonitorViewController.m
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/06/21.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import "XYZMonitorViewController.h"
#import "PNChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"

@interface XYZMonitorViewController () {

    PNLineChartData *data01;
    PNLineChartData *data02;
    PNLineChartData *data03;
}

@property (nonatomic, unsafe_unretained) NSMutableArray *level;

@end

@implementation XYZMonitorViewController


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
    //Timer for loop process to fetch water level
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(printData:) userInfo:nil repeats:YES];
    NSTimer *timerForChart = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(refreshChart:) userInfo:nil repeats:YES];
    
    //*************************************************************** Graph switch *************************************************
    
    [self.chartSwitch addTarget:self action:@selector(graphSwitching:)forControlEvents:UIControlEventValueChanged];
    
    self.colorBoxRO.backgroundColor = PNTwitterColor;
    self.colorBoxIE.backgroundColor = PNStarYellow;
    self.colorBoxJNS.backgroundColor = PNRed;
    self.colorBoxModule.backgroundColor = PNTwitterColor;
    self.colorBoxKSfilter.backgroundColor = PNStarYellow;
    self.colorBoxUV.backgroundColor = PNRed;

    //*************************************************************** Activity indicator *************************************************

    //[self.activityIcon startAnimating];
    
    //*************************************************************** Level check *************************************************
    
    if ([self.ieView.text doubleValue] <= ieLimitWarning) {
        self.ieView.textColor = PNRed;
    } else { self.ieView.textColor = PNFreshGreen;}
    if ([self.roView.text doubleValue] <= roLimitWarning) {
        self.roView.textColor = PNRed;
    } else { self.roView.textColor = PNFreshGreen;}
    if ([self.junkansuiView.text doubleValue] <= junkansuiLimitWarning) {
        self.junkansuiView.textColor = PNRed;
    } else { self.junkansuiView.textColor = PNFreshGreen;}

    //************************************************************ Chart hide ****************************************************************
  
    self.colorBoxModule.hidden = YES;
    self.colorBoxKSfilter.hidden = YES;
    self.colorBoxUV.hidden = YES;
    self.graphLabelModule.hidden = YES;
    self.graphLabelKSfilter.hidden = YES;
    self.graphLabelUV.hidden = YES;
    
    self.colorBoxRO.hidden = YES;
    self.colorBoxIE.hidden = YES;
    self.colorBoxJNS.hidden = YES;
    self.graphLabelRO.hidden = YES;
    self.graphLabelIE.hidden = YES;
    self.graphLabelJNS.hidden = YES;
    
    //************************************************************ Line chart drawing ****************************************************************
    
    self.lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 100, SCREEN_WIDTH, 30)];
    self.lineChartLabel.text = @"水質監視グラフ";
    self.lineChartLabel.textColor = PNFreshGreen;
    self.lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    self.lineChartLabel.textAlignment = NSTextAlignmentCenter;
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(135, 145.0, SCREEN_WIDTH, 200.0)];
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    
    [self.lineChart setXLabels:@[@"現在時刻",@"2 秒前",@"4 秒前",@"6 秒前",@"8 秒前",@"10 秒前",@"12 秒前"]];
    //[self.lineChart setYLabels:@[@"0.0",@"1.0",@"2.0",@"3.0",@"4.0",@"5.0",@"6.0"]];
    //lineChart.axisColor = PNFreshGreen;
    self.lineChart.showCoordinateAxis = YES;
    self.lineChart.tintColor = PNFreshGreen;
    
    // Line Chart Nr.1--------------------------------------------------------------------------------
    NSArray * data01Array = @[@0.0, @0.0, @0.0, @0.0, @0.0, @0.0, @0.0];
    data01 = [PNLineChartData new];
    data01.color = PNTwitterColor;
    data01.itemCount = self.lineChart.xLabels.count;
    data01.inflexionPointStyle = PNLineChartPointStyleCycle;
    
    // Line Chart Nr.2--------------------------------------------------------------------------------
    NSArray * data02Array = @[@0.0, @0.0, @0.0, @0.0, @0.0, @0.0, @0.0];
    data02 = [PNLineChartData new];
    data02.color = PNStarYellow;
    data02.itemCount = self.lineChart.xLabels.count;
    data02.inflexionPointStyle = PNLineChartPointStyleSquare;
    
    // Line Chart Nr.3--------------------------------------------------------------------------------
    NSArray * data03Array = @[@0.0, @0.0, @0.0, @0.0, @0.0, @0.0, @0.0];
    data03 = [PNLineChartData new];
    data03.color = PNRed;
    data03.itemCount = self.lineChart.xLabels.count;
    data03.inflexionPointStyle = PNLineChartPointStyleSquare;
    
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [[data01Array objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [[data02Array objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    data03.getData = ^(NSUInteger index) {
        CGFloat yValue = [[data03Array objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    /*
    self.lineChart.chartData = @[data01, data02, data03];
    [self.lineChart strokeChart];
    
    self.lineChart.delegate = self;
    [self.view addSubview:self.lineChartLabel];
    [self.view addSubview:self.lineChart];
    self.lineChart.hidden = YES;
    self.lineChartLabel.hidden = YES; */
    
    
    //************************************************************ Bar chart initialize ****************************************************************
    
    self.barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 100, SCREEN_WIDTH, 30)];
    self.barChartLabel.text = @"使用時間監視グラフ";
    self.barChartLabel.textColor = PNFreshGreen;
    self.barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    self.barChartLabel.textAlignment = NSTextAlignmentCenter;
    
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(135, 145.0, SCREEN_WIDTH, 200.0)];
    self.barChart.backgroundColor = [UIColor clearColor];
    self.barChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
        return labelText;
    };
    self.barChart.labelMarginTop = 8.0;
    [self.barChart setXLabels:@[@"モジュール",@"フィルター",@"UVポンプ"]];
    [self.barChart setYValues:@[@"10",@"20",@"30"]];
    [self.barChart setStrokeColors:@[PNTwitterColor,PNStarYellow,PNRed]];
    [self.barChart strokeChart];
    
    self.barChart.delegate = self;
    [self.view addSubview:self.barChartLabel];
    [self.view addSubview:self.barChart];
    self.barChart.hidden = YES;
    self.barChartLabel.hidden = YES;
    
    //************************************************************ timer ****************************************************************
    
    [self printData:timer];
    [self refreshChart:timerForChart];
    [super viewDidLoad];

} // viewDidLoad ends


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex andPointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}


-(void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}


- (void)userClickedOnBarCharIndex:(NSInteger)barIndex
{
    
    NSLog(@"Click on bar %@", @(barIndex));
    
    PNBar * bar = [self.barChart.bars objectAtIndex:barIndex];
    
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue= @1.0;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.toValue= @1.1;
    
    animation.duration= 0.2;
    
    animation.repeatCount = 0;
    
    animation.autoreverses = YES;
    
    animation.removedOnCompletion = YES;
    
    animation.fillMode=kCAFillModeForwards;
    
    [bar.layer addAnimation:animation forKey:@"Float"];
}

-(void)graphSwitching:(UISegmentedControl*)seg{

    //************************************************************ Line chart drawing ****************************************************************

if (self.chartSwitch.selectedSegmentIndex == 0) {
    
    self.barChart.hidden = YES;
    self.barChartLabel.hidden = YES;
    
    self.colorBoxModule.hidden = YES;
    self.colorBoxKSfilter.hidden = YES;
    self.colorBoxUV.hidden = YES;
    self.graphLabelModule.hidden = YES;
    self.graphLabelKSfilter.hidden = YES;
    self.graphLabelUV.hidden = YES;
    
    //self.lineChartLabel.hidden = NO;
    self.lineChart.hidden = NO;
    
    self.colorBoxRO.hidden = NO;
    self.colorBoxIE.hidden = NO;
    self.colorBoxJNS.hidden = NO;
    self.graphLabelRO.hidden = NO;
    self.graphLabelIE.hidden = NO;
    self.graphLabelJNS.hidden = NO;

        //self.title = @"Line Chart";
    
    }
    
    //************************************************************ Bar chart drawing ****************************************************************
    
else if (self.chartSwitch.selectedSegmentIndex == 1) {
    
    self.lineChart.hidden = YES;
    self.lineChartLabel.hidden = YES;
    
    self.colorBoxRO.hidden = YES;
    self.colorBoxIE.hidden = YES;
    self.colorBoxJNS.hidden = YES;
    self.graphLabelRO.hidden = YES;
    self.graphLabelIE.hidden = YES;
    self.graphLabelJNS.hidden = YES;
    
    self.barChartLabel.hidden = NO;
    self.barChart.hidden = NO;
    
    self.colorBoxModule.hidden = NO;
    self.colorBoxKSfilter.hidden = NO;
    self.colorBoxUV.hidden = NO;
    self.graphLabelModule.hidden = NO;
    self.graphLabelKSfilter.hidden = NO;
    self.graphLabelUV.hidden = NO;
         
         //self.title = @"Bar Chart";
         //self.ieView.text = [[XYZCommunicator commonCommunicator].ieLog subarrayWithRange:NSMakeRange(count % 7, 1)] ; */

    }
}

//************************************************************ Converting string to array ****************************************************************

- (NSArray *)convertToArray: (NSString *)string {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < string.length; i ++) {
        [array addObject:[NSString stringWithFormat:@"%c", [string characterAtIndex:i]]];
    }
    return array;
}

//************************************************************ Loop for fetchind data ****************************************************************


- (void)printData : (NSTimer *)timer
{
    if ([[XYZCommunicator commonCommunicator] isOpened] ) {
    [self.activityIcon startAnimating];
    self.alarmLabel.text = @"データ取得中";
    
    self.roView.text = [NSString stringWithFormat:@"%@",[[self getMsg] objectAtIndex:2]];
    self.roView.text = [self.roView.text stringByAppendingString:[[self getMsg] objectAtIndex:3]];
    self.roView.text = [self.roView.text stringByAppendingString:[[self getMsg] objectAtIndex:4]];
    
    self.ieView.text = [NSString stringWithFormat:@"%@",[[self getMsg] objectAtIndex:5]];
    self.ieView.text = [self.ieView.text stringByAppendingString:[[self getMsg] objectAtIndex:6]];
    self.ieView.text = [self.ieView.text stringByAppendingString:[[self getMsg] objectAtIndex:7]];
    
    self.junkansuiView.text = [NSString stringWithFormat:@"%@",[[self getMsg] objectAtIndex:8]];
    self.junkansuiView.text = [self.junkansuiView.text stringByAppendingString:[[self getMsg] objectAtIndex:9]];
    self.junkansuiView.text = [self.junkansuiView.text stringByAppendingString:[[self getMsg] objectAtIndex:10]];
    
    }
    
    else {
        
        [XYZCommunicator commonCommunicator]->host = @"http://192.168.1.10";
        
        [XYZCommunicator commonCommunicator]->port = 15000;
        
        [[XYZCommunicator commonCommunicator] setup];
        
        [[XYZCommunicator commonCommunicator] open];
    }
    
    //[bufferRoLevel insertObject:[[self getMsg] objectAtIndex:2] atIndex:(bufferCounter % 7)];

    //[bufferIeLevel insertObject:[[self getMsg] objectAtIndex:3] atIndex:(bufferCounter % 7)];

    //[bufferJunLevel insertObject:[[self getMsg] objectAtIndex:4] atIndex:(bufferCounter % 7)];
    
    //Line chart ------------------------------------------------------
    /*data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [[bufferRoLevel objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };

    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [[bufferIeLevel objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    data03.getData = ^(NSUInteger index) {
        CGFloat yValue = [[bufferJunLevel objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChart.chartData = @[data01, data02, data03];
    [self.lineChart strokeChart];*/
    
}

- (NSArray *)getMsg {
    return [self convertToArray:readMsg];
}

- (void)refreshChart : (NSTimer *)timer1
{
    if ([[XYZCommunicator commonCommunicator] isOpened]) {
    
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [[bufferIeLevel objectAtIndex:index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        data02.getData = ^(NSUInteger index) {
            CGFloat yValue = [[bufferRoLevel objectAtIndex:index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        data03.getData = ^(NSUInteger index) {
            CGFloat yValue = [[bufferJunLevel objectAtIndex:index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        
        self.lineChart.chartData = @[data01, data02, data03];
        [self.lineChart strokeChart];
        
        self.lineChart.delegate = self;
        //[self.view addSubview:self.lineChartLabel];
        [self.view addSubview:self.lineChart];
    }
    
    else {
        [XYZCommunicator commonCommunicator]->host = @"http://192.168.1.10";
        
        [XYZCommunicator commonCommunicator]->port = 15000;
        
        [[XYZCommunicator commonCommunicator] setup];
        
        [[XYZCommunicator commonCommunicator] open];
    }
}

@end

