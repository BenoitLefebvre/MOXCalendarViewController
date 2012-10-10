//
//  CalendarViewController.m
//  845
//
//  Created by Benoit Lefebvre on 2012-08-14.
//  Copyright (c) 2012 Benoit Lefebvre. All rights reserved.
//

#import "CalendarViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewCalendarDay.h"
#import "../BENStuff/NSDate+missingFunctions.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController
@synthesize delegate;

#pragma mark - Basic/Default

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSDate *today = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit fromDate:today];

        NSInteger day = [components day];
        NSInteger month = [components month];
        NSInteger year = [components year];
        
        date = [NSDate dateWithYear:year month:month day:day];
        
        selectedDate = date;
        arrayMonths = [NSArray arrayWithObjects:@"ERROR", @"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [viewHeader setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"VerticalGradient44px.png"]]];
    [viewHeader.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [viewHeader.layer setBorderWidth:1.0f];
    {
        lblMonth = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        [lblMonth setTextAlignment:NSTextAlignmentCenter];
        [lblMonth setBackgroundColor:[UIColor clearColor]];
        [lblMonth setTextColor:[UIColor darkGrayColor]];
        [lblMonth setFont:[UIFont boldSystemFontOfSize:20]];
        [lblMonth setShadowColor:[UIColor whiteColor]];
        [lblMonth setShadowOffset:CGSizeMake(0, 1)];
        [viewHeader addSubview:lblMonth];
        
        UIButton *btnArrowLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnArrowLeft setFrame:CGRectMake(0, 0, 44, 30)];
        [btnArrowLeft setImage:[UIImage imageNamed:@"ArrowLeft.png"] forState:UIControlStateNormal];
        [btnArrowLeft addTarget:self action:@selector(backOneMonth) forControlEvents:UIControlEventTouchUpInside];
        [viewHeader addSubview:btnArrowLeft];
        
        UIButton *btnArrowRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnArrowRight setFrame:CGRectMake(320 - 44, 0, 44, 30)];
        [btnArrowRight setImage:[UIImage imageNamed:@"ArrowRight.png"] forState:UIControlStateNormal];
        [btnArrowRight addTarget:self action:@selector(forwardOneMonth) forControlEvents:UIControlEventTouchUpInside];
        [viewHeader addSubview:btnArrowRight];
        
        int intDayHeight = 28;
        
        UILabel *lblSun = [[UILabel alloc] initWithFrame:CGRectMake(320/7*0, intDayHeight, 320/7, 12)];
        [lblSun setTextAlignment:NSTextAlignmentCenter];
        [lblSun setBackgroundColor:[UIColor clearColor]];
        [lblSun setTextColor:[UIColor darkGrayColor]];
        [lblSun setFont:[UIFont boldSystemFontOfSize:11]];
        [lblSun setShadowColor:[UIColor whiteColor]];
        [lblSun setShadowOffset:CGSizeMake(0, 1)];
        [lblSun setText:@"Sun"];
        [viewHeader addSubview:lblSun];
        
        UILabel *lblMon = [[UILabel alloc] initWithFrame:CGRectMake(320/7*1, intDayHeight, 320/7, 12)];
        [lblMon setTextAlignment:NSTextAlignmentCenter];
        [lblMon setBackgroundColor:[UIColor clearColor]];
        [lblMon setTextColor:[UIColor darkGrayColor]];
        [lblMon setFont:[UIFont boldSystemFontOfSize:11]];
        [lblMon setShadowColor:[UIColor whiteColor]];
        [lblMon setShadowOffset:CGSizeMake(0, 1)];
        [lblMon setText:@"Mon"];
        [viewHeader addSubview:lblMon];
        
        UILabel *lblTue = [[UILabel alloc] initWithFrame:CGRectMake(320/7*2, intDayHeight, 320/7, 12)];
        [lblTue setTextAlignment:NSTextAlignmentCenter];
        [lblTue setBackgroundColor:[UIColor clearColor]];
        [lblTue setTextColor:[UIColor darkGrayColor]];
        [lblTue setFont:[UIFont boldSystemFontOfSize:11]];
        [lblTue setShadowColor:[UIColor whiteColor]];
        [lblTue setShadowOffset:CGSizeMake(0, 1)];
        [lblTue setText:@"Tue"];
        [viewHeader addSubview:lblTue];
        
        UILabel *lblWed = [[UILabel alloc] initWithFrame:CGRectMake(320/7*3, intDayHeight, 320/7, 12)];
        [lblWed setTextAlignment:NSTextAlignmentCenter];
        [lblWed setBackgroundColor:[UIColor clearColor]];
        [lblWed setTextColor:[UIColor darkGrayColor]];
        [lblWed setFont:[UIFont boldSystemFontOfSize:11]];
        [lblWed setShadowColor:[UIColor whiteColor]];
        [lblWed setShadowOffset:CGSizeMake(0, 1)];
        [lblWed setText:@"Wed"];
        [viewHeader addSubview:lblWed];
        
        UILabel *lblThu = [[UILabel alloc] initWithFrame:CGRectMake(320/7*4, intDayHeight, 320/7, 12)];
        [lblThu setTextAlignment:NSTextAlignmentCenter];
        [lblThu setBackgroundColor:[UIColor clearColor]];
        [lblThu setTextColor:[UIColor darkGrayColor]];
        [lblThu setFont:[UIFont boldSystemFontOfSize:11]];
        [lblThu setShadowColor:[UIColor whiteColor]];
        [lblThu setShadowOffset:CGSizeMake(0, 1)];
        [lblThu setText:@"Thu"];
        [viewHeader addSubview:lblThu];
        
        UILabel *lblFri = [[UILabel alloc] initWithFrame:CGRectMake(320/7*5, intDayHeight, 320/7, 12)];
        [lblFri setTextAlignment:NSTextAlignmentCenter];
        [lblFri setBackgroundColor:[UIColor clearColor]];
        [lblFri setTextColor:[UIColor darkGrayColor]];
        [lblFri setFont:[UIFont boldSystemFontOfSize:11]];
        [lblFri setShadowColor:[UIColor whiteColor]];
        [lblFri setShadowOffset:CGSizeMake(0, 1)];
        [lblFri setText:@"Fri"];
        [viewHeader addSubview:lblFri];
        
        UILabel *lblSat = [[UILabel alloc] initWithFrame:CGRectMake(320/7*6, intDayHeight, 320/7, 12)];
        [lblSat setTextAlignment:NSTextAlignmentCenter];
        [lblSat setBackgroundColor:[UIColor clearColor]];
        [lblSat setTextColor:[UIColor darkGrayColor]];
        [lblSat setFont:[UIFont boldSystemFontOfSize:11]];
        [lblSat setShadowColor:[UIColor whiteColor]];
        [lblSat setShadowOffset:CGSizeMake(0, 1)];
        [lblSat setText:@"Sat"];
        [viewHeader addSubview:lblSat];
    }
    [self.view addSubview:viewHeader];
    
    viewDays = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 10)];
    [viewDays.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [viewDays.layer setBorderWidth:1.0f];
    [self.view addSubview:viewDays];
    
    [self reloadView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Reload View

- (void)loadViewDays
{
    UIView *newViewDays = [[UIView alloc] init];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit fromDate:date];
    
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    NSDate *firstDayOfMonth = [NSDate dateWithYear:year month:month day:1];
    
    NSDateComponents *componentFirstDay = [cal components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth];
    
    int viewTop = 0;
    int intDayNumber = 0;
    for (int i = 1; i < [componentFirstDay weekday]; i++) {
        intDayNumber++;
        ViewCalendarDay *calDay = [[ViewCalendarDay alloc] initWithFrame:CGRectMake(((320/7+0.5) * (intDayNumber -1))+1, viewTop, 320/7+0.5, 320/7+0.5)];
        
        NSDateComponents *tmpComponent = [[NSDateComponents alloc] init];
        [tmpComponent setCalendar:cal];
        int offset = (int) [componentFirstDay weekday] - i;
        [tmpComponent setDay:-offset];
        
        NSDate *tmpDate = [cal dateByAddingComponents:tmpComponent toDate:firstDayOfMonth options:0];
        
        [calDay setDate:tmpDate];
        [calDay setDelegate:self];
        
        [calDay setGrayedOut];
        
        [newViewDays addSubview:calDay];
        
        if (intDayNumber % 7 == 0) {
            viewTop += 320/7;
        }
    }
    
    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSUInteger numberOfDaysInMonth = rng.length;
    
    for (int i = 1 ; i <= numberOfDaysInMonth; i++) {
        intDayNumber++;
        
        ViewCalendarDay *calDay = [[ViewCalendarDay alloc] initWithFrame:CGRectMake(((320/7+0.5) * (intDayNumber -1))+1, viewTop, 320/7+0.5, 320/7+0.5)];
        
        NSDate *tmpDate = [NSDate dateWithYear:year month:month day:i];
        
        [calDay setDate:tmpDate];
        [calDay setDelegate:self];
        
        if ([tmpDate compare:selectedDate] == NSOrderedSame) {
            [calDay setToday];
        }
        
        [newViewDays addSubview:calDay];
        
        if (intDayNumber % 7 == 0) {
            viewTop += 320/7;
            intDayNumber = 0;
        }
    }
    
    if (intDayNumber % 7 != 0) {
        int loopMax = 7 - (intDayNumber % 7);
        for (int i = 1; i <= loopMax; i++) {
            intDayNumber++;
            ViewCalendarDay *calDay = [[ViewCalendarDay alloc] initWithFrame:CGRectMake(((320/7+0.5) * (intDayNumber -1))+1, viewTop, 320/7+0.5, 320/7+0.5)];
            
            NSDate *tmpDate = [NSDate dateWithYear:year month:month+1 day:i];
            
            [calDay setDate:tmpDate];
            [calDay setDelegate:self];
            
            [calDay setGrayedOut];
            
            [newViewDays addSubview:calDay];

        }
        viewTop += 320/7;        
    }
    
    [newViewDays setFrame:CGRectMake(newViewDays.frame.origin.x, newViewDays.frame.origin.y, 320, viewTop)];
    
    [viewDays addSubview:newViewDays];
    
    [viewDays setFrame:CGRectMake(viewDays.frame.origin.x, viewDays.frame.origin.y, 320, newViewDays.frame.size.height)];
}

- (void)reloadView
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit fromDate:date];
    
    //NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    //NSInteger weekday = [components weekday]; // Sunday = 1, Saturday = 7
    
    NSString *stringMonth = [arrayMonths objectAtIndex:month];

    [lblMonth setText:[NSString stringWithFormat:@"%@ %i", stringMonth, year]];
    
    for (int i = 0; i < [[viewDays subviews] count]; i++) {
        [[[viewDays subviews] objectAtIndex:i] removeFromSuperview];
    }
    [self loadViewDays];
}

#pragma mark - Move in Month
- (void)backOneMonth
{
    NSCalendar *cal = [NSCalendar currentCalendar];

    NSDateComponents *newComponent = [[NSDateComponents alloc] init];
    [newComponent setCalendar:cal];
    [newComponent setMonth:-1];
    
    date = [cal dateByAddingComponents:newComponent toDate:date options:0];

    [self reloadView];
}

- (void)forwardOneMonth
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *newComponent = [[NSDateComponents alloc] init];
    [newComponent setCalendar:cal];
    [newComponent setMonth:+1];
    
    date = [cal dateByAddingComponents:newComponent toDate:date options:0];
    
    [self reloadView];
}

#pragma mark - Date

- (void)goToday
{
    NSDate *today = [NSDate date];

    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [cal components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:today];
    
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    date = [NSDate dateWithYear:year month:month day:day];
    
    selectedDate = date;

    [self reloadView];
    
    [self ViewCalendarDay:nil clickedOnDate:date];
}

- (void)setDate:(NSDate *)newDate
{
    if (newDate) {
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        NSDateComponents *components = [cal components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:newDate];
        
        NSInteger day = [components day];
        NSInteger month = [components month];
        NSInteger year = [components year];
        
        date = [NSDate dateWithYear:year month:month day:day];
        
        selectedDate = date;
        
        [self reloadView];
    }
}

#pragma mark - ViewCalendarDayDeleg                                                                                                                                                                                                                   ate

- (void)ViewCalendarDay:(ViewCalendarDay *)viewCalendarDay clickedOnDate:(NSDate *)clickedDate
{
    selectedDate = clickedDate;
    [self setDate:clickedDate];
    if ([delegate conformsToProtocol:@protocol(CalendarViewControllerDelegate)] && [delegate respondsToSelector:@selector(CalendarViewController:clickedOnDate:)]) {
        [delegate CalendarViewController:self clickedOnDate:date];
    }

}

@end
