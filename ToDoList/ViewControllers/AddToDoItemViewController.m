//
//  AddToDoItemViewController.m
//  ToDoList
//
//  Created by Youngho Yoo on 2014-08-23.
//
//

#import "AddToDoItemViewController.h"
#import "NSDate+Utilities.h"

@interface AddToDoItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDatePicker;

@end

@implementation AddToDoItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Focus on text field when view launches
    [self.textField becomeFirstResponder];
}

#pragma mark - Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Don't create the toDoItem if the "cancel" button was pressed
    if (sender != self.doneButton) return;
    if (self.textField.text.length > 0) {
        self.toDoItem = [[ToDoItem alloc] init];
        self.toDoItem.itemName = self.textField.text;
        self.toDoItem.completed = NO;
        self.toDoItem.dueDate = [NSDate dateWithoutTime:self.dueDatePicker.date];
    }
}

@end
