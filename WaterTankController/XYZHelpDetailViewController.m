//
//  TCTLDetailViewController.m
//  master
//
//  Created by MACmachineHitechlab on 2014/07/04.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import "XYZHelpDetailViewController.h"

@interface XYZHelpDetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;

@end

@implementation XYZHelpDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.alarmView.text = nil;
        //self.detailDescriptionLabel.text = [self.detailItem description];
        self.alarmView.text = @"この項目に対する詳細な説明が以下に表示される：\n\n";
        self.alarmView.text = [self.alarmView.text stringByAppendingString:[self.detailItem description]];
        //self.alarmView.text = [self.alarmView.text stringByAppendingString:@"\n\n"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

/*
 - (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
 {
 barButtonItem.title = NSLocalizedString(@"Master", @"Menu");
 [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
 self.masterPopoverController = popoverController;
 }
 */

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
