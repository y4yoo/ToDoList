//
//  ToDoItemsDataStructure.m
//  ToDoList
//
//  Created by Youngho Yoo on 2014-10-13.
//
//

#import "ToDoItemsDataStructure.h"
#import "ToDoItem.h"
#import "NSDate+Utilities.h"

@interface ToDoItemsDataStructure()

@property NSMutableDictionary *allItems;

@end

@implementation ToDoItemsDataStructure

- (NSInteger *)numberOfUniqueDates
{
    return (NSInteger *)[self.allItems count];
}

- (void)addToDoItem:(ToDoItem *)item
{
    item.dueDate = [NSDate dateWithoutTime:item.dueDate];
}

- (void)removeToDoItem:(NSIndexPath *)indexPath
{
    indexPath.row;
    indexPath.item;
}

@end
