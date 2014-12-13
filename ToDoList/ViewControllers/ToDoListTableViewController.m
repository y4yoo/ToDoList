#import "ToDoListTableViewController.h"
#import "AddToDoItemViewController.h"
#import "AppDelegate.h"
#import "ToDoItem.h"
#import "HeaderViewCell.h"

@interface ToDoListTableViewController ()

@property NSMutableArray *toDoItems;

@end

@implementation ToDoListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.toDoListTableViewController = self;
    
    [self registerCells];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    [self loadInitialData];
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

#pragma mark - TableView lifecycle

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // The number of sections should be the number of unique dates
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of tasks due on a specific date
    return [self.toDoItems count];
}

#pragma mark - Table cell

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    HeaderViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HeaderViewCell class])];
    return headerView.frame.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HeaderViewCell class])];
    [headerView setupWithDate:[NSDate date]];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ToDoItem class]) forIndexPath:indexPath];
    
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

#pragma mark - Private

- (void)registerCells
{
    UINib *toDoItemCell = [UINib nibWithNibName:NSStringFromClass([ToDoItem class]) bundle:nil];
    [self.tableView registerNib:toDoItemCell forCellReuseIdentifier:NSStringFromClass([ToDoItem class])];
    UINib *HeaderCell = [UINib nibWithNibName:NSStringFromClass([HeaderViewCell class]) bundle:nil];
    [self.tableView registerNib:HeaderCell forCellReuseIdentifier:NSStringFromClass([HeaderViewCell class])];
    
}

@end
