//
//  XYZHelpMasterViewController.h
//  WaterTankController
//
//  Created by MACmachineHitechlab on 2014/07/16.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYZHelpDetailViewController;

@interface XYZHelpMasterViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searcher;

@property (strong, nonatomic) XYZHelpDetailViewController *detailViewController;

@end
