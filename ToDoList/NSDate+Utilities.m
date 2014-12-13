//
//  NSDate+Utilities.m
//  ToDoList
//
//  Created by Youngho Yoo on 2014-12-06.
//
//

#import "NSDate+Utilities.h"

@implementation NSDate (Utilities)

+ (NSDate *)dateWithoutTime:(NSDate *)date
{
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

/*
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
*/

+ (NSString * )headerViewFormatDate:(NSDate *)date
{
    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    [weekday setDateFormat: @"EEEE, MMMM d"];
    return [weekday stringFromDate:date];
}

@end
