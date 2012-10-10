//
//  CalendarViewController.h
//  845
//
//  Created by Benoit Lefebvre on 2012-08-14.
//  Copyright (c) 2012 Benoit Lefebvre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewCalendarDay.h"

@class CalendarViewController;

@protocol CalendarViewControllerDelegate <NSObject>
@optional
- (void)CalendarViewController:(CalendarViewController *)calendarViewController clickedOnDate:(NSDate *)clickedDate;
@end

@interface CalendarViewController : UIViewController <ViewCalendarDayDelegate>
{
    NSDate *date;
    NSDate *selectedDate;
    NSArray *arrayMonths;
    
    // Interface
    UILabel *lblMonth;
    UIView *viewDays;
}

@property (nonatomic, retain) id<CalendarViewControllerDelegate> delegate;

- (void)setDate:(NSDate *)newDate;

@end
