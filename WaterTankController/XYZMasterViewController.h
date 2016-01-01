//
//  TCTLMasterViewController.h
//  master
//
//  Created by MACmachineHitechlab on 2014/07/04.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"

@class XYZDetailViewController;

@interface XYZMasterViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searcher;

@property (strong, nonatomic) XYZDetailViewController *detailViewController;

@end
