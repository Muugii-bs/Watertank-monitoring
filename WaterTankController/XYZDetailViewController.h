//
//  TCTLDetailViewController.h
//  master
//
//  Created by MACmachineHitechlab on 2014/07/04.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UITextView *alarmView;
@end
