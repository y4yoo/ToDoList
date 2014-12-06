//
//  ToDoItem.m
//  ToDoList
//
//  Created by Youngho Yoo on 2014-08-25.
//
//

#import "ToDoItem.h"

@interface ToDoItem ()

@end

@implementation ToDoItem

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.itemName = [decoder decodeObjectForKey:@"itemName"];
    self.completed = [decoder decodeBoolForKey:@"completed"];
    self.dueDate = [decoder decodeObjectForKey:@"dueDate"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.itemName forKey:@"itemName"];
    [encoder encodeBool:self.completed forKey:@"completed"];
    [encoder encodeObject:self.dueDate forKey:@"dueDate"];
}

@end
