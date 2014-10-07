//
//  ToDoItem.m
//  ToDoList
//
//  Created by Youngho Yoo on 2014-08-25.
//
//

#import "ToDoItem.h"

@implementation ToDoItem

#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.itemName = [decoder decodeObjectForKey:@"itemName"];
    self.completed = [decoder decodeBoolForKey:@"completed"];
    self.creationDate = [decoder decodeObjectForKey:@"creationDate"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.itemName forKey:@"itemName"];
    [encoder encodeBool:self.completed forKey:@"completed"];
    [encoder encodeObject:self.creationDate forKey:@"creationDate"];
}

@end
