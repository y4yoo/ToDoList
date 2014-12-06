//
//  NSDateHelper.m
//  ToDoList
//
//  Created by Youngho Yoo on 2014-10-13.
//
//

#import "NSDateHelper.h"

@implementation NSDateHelper

+ (NSDate *)dateWithoutTime:(NSDate *)date
{
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

+ (NSInteger *)numberOfUniqueDates:(NSArray *)dates
{
    NSMutableDictionary *uniqueDates = [NSMutableDictionary new];
    for (NSDate *date in dates) {
        if ([uniqueDates objectForKey:date]) {
            //
        } else {
            [uniqueDates setObject:@1 forKey:date];
        }
    }
    return NSUIntegerMax;
}

@end
