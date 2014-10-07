//
//  ToDoListTableViewController.m
//  ToDoList
//
//  Created by Youngho Yoo on 2014-08-24.
//
//

#import "ToDoListTableViewController.h"
#import "ToDoItem.h"
#import "AddToDoItemViewController.h"
#import "AppDelegate.h"

@interface ToDoListTableViewController ()

@property NSMutableArray *toDoItems;

@end

@implementation ToDoListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.toDoListTableViewController = self;
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    [self loadInitialData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Delete Task

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        [self.toDoItems removeObjectAtIndex:[indexPath indexAtPosition:1]];
        [self.tableView reloadData];
    }
}

#pragma mark - 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.toDoItems count];
}

#pragma mark - Table cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    ToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem.itemName;
    if (toDoItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (IBAction)unwindToList: (UIStoryboardSegue *)segue
{
    AddToDoItemViewController *source = [segue sourceViewController];
    ToDoItem *toDoItem = source.toDoItem;
    if (toDoItem != nil) {
        [self.toDoItems addObject:toDoItem];
        [self.tableView reloadData];
    }
}

#pragma mark - Data Management

- (void)loadInitialData {
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [docsPath stringByAppendingPathComponent:@"tasks"];
    
    NSArray *entries = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    
    self.toDoItems = [NSMutableArray arrayWithArray:entries];
}

- (BOOL) saveToDoItems {
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [docsPath stringByAppendingPathComponent:@"tasks"];
    
    return [NSKeyedArchiver archiveRootObject:self.toDoItems toFile:filename];
}

@end
