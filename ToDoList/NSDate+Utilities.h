//
//  NSDate+Utilities.h
//  ToDoList
//
//  Created by Youngho Yoo on 2014-12-06.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Utilities)

+ (NSDate *)dateWithoutTime:(NSDate *)date;
+ (NSString *)headerViewFormatDate:(NSDate *)date;

@end
