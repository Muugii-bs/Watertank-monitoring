//
//  XYZHomeViewController.m
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/06/21.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import "XYZHomeViewController.h"

@interface XYZHomeViewController ()

@end

@implementation XYZHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
-(IBAction)switchToSplit:(id)sender {
    UISplitViewController *split = [self.storyboard instantiateViewControllerWithIdentifier:@"Split"];
    self.view.window.rootViewController = split;
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    for (int i=0; i<textArray1.count; i++) {
        self.display.text = [self.display.text stringByAppendingString:[textArray1 objectAtIndex:i]];
        self.display.text = [self.display.text stringByAppendingString:@"\n"];
    }
    
 //   if (textArray) {
 //       self.display.text = [self.display.text stringByAppendingString:[textArray1 objectAtIndex:0]];
  //      self.display.text = [self.display.text stringByAppendingString:@"\n\n"];
//for (int i=1; i<10; i++) {
 //           self.display.text = [self.display.text stringByAppendingString:[textArray1 objectAtIndex:i]];
  //          self.display.text = [self.display.text stringByAppendingString:@"\n\n"];
 //       }
  //  }
    
    //XYZRouterRecognizer *wifiChecker;
        
    //[wifiChecker wificonnection];
    
    //[self.navigationController.navigationBar setTintColor:[UIColor blueColor]];
    // Do any additional setup after loading the view.
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


@end
