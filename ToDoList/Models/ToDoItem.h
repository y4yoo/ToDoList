#import <Foundation/Foundation.h>

@interface ToDoItem : UITableViewCell <NSCoding>

@property NSString *itemName;
@property BOOL completed;
@property NSDate *dueDate;

@end