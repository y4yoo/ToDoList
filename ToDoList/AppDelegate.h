//
//  XYZAppDelegate.h
//  ToDoList
//
//  Created by Youngho Yoo on 2014-08-21.
//
//

#import <UIKit/UIKit.h>
@class ToDoListTableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property ToDoListTableViewController *toDoListTableViewController;

@end
