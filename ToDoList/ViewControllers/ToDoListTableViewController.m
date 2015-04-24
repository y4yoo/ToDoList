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
    [self sortEventsbyDate];
    return [self countUniqueDate];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of tasks due on a specific date
    NSDate *sectionDate = [self dateForSection:section];
    return [self itemsForDate:sectionDate].count;
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
    [headerView setupWithDate:[self dateForSection:section]];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ToDoItem class]) forIndexPath:indexPath];
    
    NSDate *date = [self dateForSection:[indexPath indexAtPosition:0]];
    NSMutableArray *items = [self itemsForDate:date];
    ToDoItem *toDoItem = [items objectAtIndex:[indexPath indexAtPosition:1]];
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

- (BOOL)saveToDoItems {
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

- (int)countUniqueDate {
    int count = 0;
    NSMutableDictionary *uniqueDates = [[NSMutableDictionary alloc] init];
    for(int i = 0; i < self.toDoItems.count; i ++) {
        NSDate *itemDueDate = ((ToDoItem *)[self.toDoItems objectAtIndex:i]).dueDate;
        if ([uniqueDates objectForKey:itemDueDate] == nil) {
            [uniqueDates setObject:@1 forKey:itemDueDate];
            count++;
        }
    }
    return count;
}

- (void)sortEventsbyDate {
    for (int i = 0; i < self.toDoItems.count ; i++) {
        ToDoItem *firstItem = [self.toDoItems objectAtIndex:i];
        int minIndex = i;
        for (int j = i; j < self.toDoItems.count; j++) {
            ToDoItem *item = [self.toDoItems objectAtIndex:j];
            if ([item.dueDate timeIntervalSince1970] < [firstItem.dueDate timeIntervalSince1970]) {
                firstItem = item;
                minIndex = j;
            }
        }
        [self.toDoItems setObject:[self.toDoItems objectAtIndex:i] atIndexedSubscript:minIndex];
        [self.toDoItems setObject:firstItem atIndexedSubscript:i];
    }
}

- (NSDate *)dateForSection:(NSInteger)section {
    if (self.toDoItems.count == 0) {
        return nil;
    }
    if (section == 0) {
        return ((ToDoItem *)[self.toDoItems objectAtIndex:0]).dueDate;
    }
    NSDate *previousDate = ((ToDoItem *)[self.toDoItems objectAtIndex:0]).dueDate;
    NSInteger sectionCount = 0;
    for (int i = 0; i < self.toDoItems.count; i++) {
        NSDate *currentDate = ((ToDoItem *)[self.toDoItems objectAtIndex:i]).dueDate;
        if ([previousDate timeIntervalSince1970] == [currentDate timeIntervalSince1970]) {
        } else {
            sectionCount++;
            previousDate = currentDate;
        }
        if (sectionCount == section) {
            break;
        }
    }
    return previousDate;
}

- (NSMutableArray *)itemsForDate:(NSDate *)date {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.toDoItems.count; i++) {
        if (date == ((ToDoItem *)[self.toDoItems objectAtIndex:i]).dueDate) {
            [items addObject:[self.toDoItems objectAtIndex:i]];
        }
    }
    return items;
}

@end
