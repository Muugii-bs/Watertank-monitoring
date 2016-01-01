//
//  TCTLMasterViewController.m
//  master
//
//  Created by MACmachineHitechlab on 2014/07/04.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import "XYZMasterViewController.h"

#import "XYZDetailViewController.h"

@interface XYZMasterViewController () {
    
    NSMutableArray *filteredDate;
    NSMutableArray *filteredDescription;
    NSMutableArray *filteredDetail;
    NSMutableArray *date;
    NSMutableArray *detail;
    NSMutableArray *description;
    
    BOOL searchTextFlag;
    BOOL foundFlag;
    int counter;
}
@end

@implementation XYZMasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    counter = 0;
    foundFlag = false;
    date = [[NSMutableArray alloc] init];
    description = [[NSMutableArray alloc] init];
    detail = [[NSMutableArray alloc] init];

	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    
    self.detailViewController = (XYZDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    for (int i = 0; i < alarmLogDate.count; i++) {
        [date insertObject:[alarmLogDate objectAtIndex:i] atIndex:i];
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        //[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    for (int i = 0; i < alarmLogDescription.count; i++) {
        [description insertObject:[alarmLogDescription objectAtIndex:i] atIndex:i];
        NSLog(@"%@   %@\n\n",[date objectAtIndex:i],[description objectAtIndex:i]);
    }
    
    for (int i = 0; i < alarmLogDetail.count; i++) {
        [detail insertObject:[alarmLogDetail objectAtIndex:i] atIndex:i];
    }
    
    self.searcher.keyboardType = UIKeyboardTypeDefault;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    if (!_date) {
        _date = [[NSMutableArray alloc] init];
    }
    [_date insertObject:[NSDate date] atIndex:0];
    [_objects insertObject:[NSString stringWithFormat:@"警告 No%d",counter] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    counter ++;
}
*/

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount;
    if(foundFlag)
        rowCount = (int)filteredDate.count;
    else
        rowCount = (int)date.count;
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!foundFlag) {
        cell.textLabel.text = [date objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [detail objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [filteredDate objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [filteredDetail objectAtIndex:indexPath.row];
    }

    /*NSMutableArray *object = _objects[indexPath.row];
    NSDate *date2 = _date[indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日 HH時mm分";
    NSString *date1 = [dateFormatter stringFromDate:date2];
    cell.textLabel.text = [date1 description];
    cell.detailTextLabel.text = [object description];
    NSLog(@"%@",date1);*/
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [date removeObjectAtIndex:indexPath.row];
        [detail removeObjectAtIndex:indexPath.row];
        [description removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!foundFlag) self.detailViewController.detailItem = description[indexPath.row];
    else self.detailViewController.detailItem = filteredDescription[indexPath.row];
}

-(void)searchBarSearchButtonClicked:(UISearchBar*)searcher
{
    // [_searcher resignFirstResponder];
    NSLog(@"search button clicked\n");
    NSString *keyWord = [[NSString alloc] initWithString:[self.searcher text]];
    if (keyWord.length == 0) {
        searchTextFlag = false;
    }
    else {
        searchTextFlag = true;
        NSLog(@"%@\n\n",keyWord);
        filteredDate = [[NSMutableArray alloc] init];
        filteredDescription = [[NSMutableArray alloc] init];
        filteredDetail = [[NSMutableArray alloc] init];
        for (int i = 0; i < date.count; i++) {
            NSRange nameRange = [[date objectAtIndex:i] rangeOfString:keyWord options:NSCaseInsensitiveSearch];
            NSRange descriptionRange = [[description objectAtIndex:i] rangeOfString:keyWord options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound) {
                [filteredDate addObject:[date objectAtIndex:i]];
                [filteredDescription addObject:[description objectAtIndex:i]];
                [filteredDetail addObject:[detail objectAtIndex:i]];
                foundFlag = true;
            }
        }
    }
    [self.tableView reloadData];
}

-(void)searchBarCancelButtonClicked:(UISearchBar*)searcher
{
    self.searcher.text = nil;
    foundFlag = false;
    [self.tableView reloadData];
}

@end
