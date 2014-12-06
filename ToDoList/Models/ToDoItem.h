//
//  ToDoItem.h
//  ToDoList
//
//  Created by Youngho Yoo on 2014-08-25.
//
//

#import <Foundation/Foundation.h>

@interface ToDoItem : UITableViewCell <NSCoding>

@property NSString *itemName;
@property BOOL completed;
@property NSDate *dueDate;

@end