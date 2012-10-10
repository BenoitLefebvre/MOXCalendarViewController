//
//  ViewCalendarDay.h
//  845
//
//  Created by Benoit Lefebvre on 2012-08-15.
//  Copyright (c) 2012 Benoit Lefebvre. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewCalendarDay;

@protocol ViewCalendarDayDelegate <NSObject>
@optional
- (void)ViewCalendarDay:(ViewCalendarDay *)viewCalendarDay clickedOnDate:(NSDate *)clickedDate;
@end

@interface ViewCalendarDay : UIView
{
    NSDate *date;
    
    // Interface
    UILabel *lblDay;
}

@property (nonatomic, retain) id<ViewCalendarDayDelegate> delegate;
@property (nonatomic, retain) NSDate *date;

- (void)setGrayedOut;
- (void)setToday;

@end
