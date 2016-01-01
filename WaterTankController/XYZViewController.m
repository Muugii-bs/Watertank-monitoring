//
//  XYZViewController.m
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/05/27.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import "XYZViewController.h"

@interface XYZViewController ()

@end

@implementation XYZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *color = [UIColor colorWithRed:0.127 green:0.140 blue:0.141 alpha:1.0];
    //UIColor *color1 = [UIColor redColor];
    self.view.backgroundColor = color;
    //rgba(52, 73, 94,1.0)
   /*
	// Do any additional setup after loading the view, typically from a nib.
    //_buttonOne.frame = CGRectMake(40, 140, 240, 30);
    UIImage *buttonOneImage = [UIImage imageNamed:@"monitor.png"];
    [_buttonOne setBackgroundImage:buttonOneImage forState:UIControlStateNormal];
    //[_buttonOne setTitle:@"Title" forState:UIControlStateNormal];
    UIImage *buttonTwoImage = [UIImage imageNamed:@"info.png"];
    [_buttonTwo setBackgroundImage:buttonTwoImage forState:UIControlStateNormal];
    UIImage *buttonThreeImage = [UIImage imageNamed:@"log.png"];
    [_buttonThree setBackgroundImage:buttonThreeImage forState:UIControlStateNormal];
    UIImage *buttonFourImage = [UIImage imageNamed:@"ex.png"];
    [_buttonFour setBackgroundImage:buttonFourImage forState:UIControlStateNormal]; 
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
