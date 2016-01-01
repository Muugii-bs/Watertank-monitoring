//
//  TCTLMasterViewController.m
//  master
//
//  Created by MACmachineHitechlab on 2014/07/04.
//  Copyright (c) 2014年 Hitechlab. All rights reserved.
//

#import "XYZHelpMasterViewController.h"

#import "XYZHelpDetailViewController.h"

/*
 typedef struct hlpText
{
    __unsafe_unretained NSMutableArray *intro;
    __unsafe_unretained NSMutableArray *date;
    __unsafe_unretained NSMutableArray *desription;
} hlpText;
 */

@interface XYZHelpMasterViewController () {
    NSMutableArray *filteredIntro;
    NSMutableArray *filteredDescrition;
    NSMutableArray *filteredDate;
    NSMutableArray *intro;
    NSMutableArray *desription;
    NSMutableArray *date;
    BOOL searchTextFlag;
    BOOL foundFlag;
    int counter;
}

@end

@implementation XYZHelpMasterViewController

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
    intro = [[NSMutableArray alloc] init];
    desription = [[NSMutableArray alloc] init];
    date = [[NSMutableArray alloc] init];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    
    self.detailViewController = (XYZHelpDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    for (int i = 0; i < helpLogKey.count; i++) {
        [intro insertObject:[helpLogKey objectAtIndex:i] atIndex:i];
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    for (int i = 0; i < helpLogDetail.count; i++) {
        [desription insertObject:[helpLogDetail objectAtIndex:i] atIndex:i];
         //NSLog(@"%@   %@\n\n",[intro objectAtIndex:i],[desription objectAtIndex:i]);
    }
    
    for (int i = 0; i < helpLogIndex.count; i++) {
        [date insertObject:[helpLogIndex objectAtIndex:i] atIndex:i];
    }
    
    self.searcher.keyboardType = UIKeyboardTypeDefault;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount;
    if(foundFlag)
        rowCount = (int)filteredIntro.count;
    else
        rowCount = (int)intro.count;
    
    return rowCount;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //for (int i = 0; i < 10 ; i++)
    if (!foundFlag) {
        cell.textLabel.text = [intro objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [date objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [filteredIntro objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [filteredDate objectAtIndex:indexPath.row];
    }
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
        [intro removeObjectAtIndex:indexPath.row];
        [desription removeObjectAtIndex:indexPath.row];
        [date removeObjectAtIndex:indexPath.row];
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
    if (!foundFlag) self.detailViewController.detailItem = desription[indexPath.row];
    else self.detailViewController.detailItem = filteredDescrition[indexPath.row];
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
            filteredIntro = [[NSMutableArray alloc] init];
            filteredDescrition = [[NSMutableArray alloc] init];
            filteredDate = [[NSMutableArray alloc] init];
            for (int i = 0; i < intro.count; i++) {
                NSRange nameRange = [[intro objectAtIndex:i] rangeOfString:keyWord options:NSCaseInsensitiveSearch];
                NSRange descriptionRange = [[desription objectAtIndex:i] rangeOfString:keyWord options:NSCaseInsensitiveSearch];
                if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound) {
                    [filteredIntro addObject:[intro objectAtIndex:i]];
                    [filteredDescrition addObject:[desription objectAtIndex:i]];
                    [filteredDate addObject:[date objectAtIndex:i]];
                    foundFlag = true;
                }
            }
        }
        //if ([cell.textLabel.text objectAtIndex:i] == searchBar.text)
        
   // }
    [self.tableView reloadData];
}

-(void)searchBarCancelButtonClicked:(UISearchBar*)searcher
{
    self.searcher.text = nil;
    foundFlag = false;
    [self.tableView reloadData];
}
@end
