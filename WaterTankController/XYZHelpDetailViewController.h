//
//  XYZHelpDetailViewController.h
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/07/16.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZHelpDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *alarmView;
@property (strong, nonatomic) id detailItem;

@end
