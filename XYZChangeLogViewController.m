//
//  XYZChangeLogViewController.m
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/07/22.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import "XYZChangeLogViewController.h"

@interface XYZChangeLogViewController () {
    NSInteger cnt1;
    NSInteger cnt2;
    
    NSNotificationCenter *nCenter1;
    NSNotificationCenter *nCenter2;
}

@end

@implementation XYZChangeLogViewController

/*
+ (XYZChangeLogViewController *)commonChangeLog {
    
    static XYZChangeLogViewController *commonChangeLog;
    
    @synchronized(self)
    {
        if (!commonChangeLog)
            commonChangeLog = [[XYZChangeLogViewController alloc] init];
        return commonChangeLog;
    }
}
*/

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
    [self viewLogMessages];
    nCenter1 = [NSNotificationCenter defaultCenter];
    nCenter2 = [NSNotificationCenter defaultCenter];
    [nCenter1 addObserver:self selector:@selector(viewLogMessages) name:@"groupOneStopped" object:nil];
    [nCenter2 addObserver:self selector:@selector(viewLogMessages) name:@"groupTwoStopped" object:nil];
}

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
- (void)viewLogMessages {
    if (changeLogFilter1[0] != nil) {
        cnt1 = changeLogFilter1.count-1;
        self.textViewer1.text = [changeLogFilter1 objectAtIndex:cnt1];
        self.textViewer1.text = [self.textViewer1.text stringByAppendingString:@"\n\n"];
        while (--cnt1){
            self.textViewer1.text = [self.textViewer1.text stringByAppendingString:[changeLogFilter1 objectAtIndex:cnt1]];
            self.textViewer1.text = [self.textViewer1.text stringByAppendingString:@"\n\n"];
        }
    }
    if (changeLogFilter2[1] != nil) {
        cnt2 = changeLogFilter2.count-1;
        self.textViewer2.text = [changeLogFilter2 objectAtIndex:cnt2];
        self.textViewer2.text = [self.textViewer2.text stringByAppendingString:@"\n\n"];
        while (--cnt2){
            self.textViewer2.text = [self.textViewer2.text stringByAppendingString:[changeLogFilter2 objectAtIndex:cnt2]];
            self.textViewer2.text = [self.textViewer2.text stringByAppendingString:@"\n\n"];
        }
    }

}

@end
