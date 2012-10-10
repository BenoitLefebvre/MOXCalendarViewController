//
//  ViewCalendarDay.m
//  845
//
//  Created by Benoit Lefebvre on 2012-08-15.
//  Copyright (c) 2012 Benoit Lefebvre. All rights reserved.
//

#import "ViewCalendarDay.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewCalendarDay

@synthesize date;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:213/255.0f green:212/255.0f blue:216/255.0f alpha:1.0f]];
        //[self.layer setBorderWidth:0.5f];
        //[self.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        
        [self setClipsToBounds:true];
        
        UIView *topBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        [topBorder setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:topBorder];
        
        UIView *rightBorder = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width -1, 0, 1, self.frame.size.height)];
        [rightBorder setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:rightBorder];
        
        UIView *leftBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.frame.size.height)];
        [leftBorder setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:leftBorder];
                
        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height -1, self.frame.size.width, 1)];
        [bottomBorder setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:bottomBorder];

        CGRect newFrame = frame;
        newFrame.origin.x = 0;
        newFrame.origin.y = 0;
        
        lblDay = [[UILabel alloc] initWithFrame:newFrame];
        [lblDay setFont:[UIFont boldSystemFontOfSize:16]];
        [lblDay setTextAlignment:NSTextAlignmentCenter];
        [lblDay setBackgroundColor:[UIColor clearColor]];
        [lblDay setShadowColor:[UIColor whiteColor]];
        [lblDay setShadowOffset:CGSizeMake(0, 2)];
        [self addSubview:lblDay];
        
        UIButton *btnClickDate = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnClickDate setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [btnClickDate addTarget:self action:@selector(clickDate:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnClickDate];

    }
    return self;
}

- (void)clickDate:(id)sender
{
    if ([delegate conformsToProtocol:@protocol(ViewCalendarDayDelegate)] && [delegate respondsToSelector:@selector(ViewCalendarDay:clickedOnDate:)]) {
        [delegate ViewCalendarDay:self clickedOnDate:date];
    }
}

- (void)setDate:(NSDate *)newDate
{
    date = newDate;
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSDayCalendarUnit fromDate:date];

    NSInteger day = [components day];

    [lblDay setText:[NSString stringWithFormat:@"%i", day]];
}

- (void)setGrayedOut {
    [lblDay setTextColor:[UIColor grayColor]];
    [lblDay setShadowOffset:CGSizeMake(0, 0)];
}

- (void)setToday {
    [lblDay setTextColor:[UIColor blackColor]];
    [self setBackgroundColor:[UIColor colorWithRed:25/255.0 green:128/255.0 blue:229/255.0 alpha:1]];
    [lblDay setShadowColor:[UIColor blackColor]];
    [lblDay setShadowOffset:CGSizeMake(0, 1)];
    [lblDay setTextColor:[UIColor whiteColor]];

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(-10, -10, self.frame.size.width +20, 10)];
    [topView setBackgroundColor:[UIColor blackColor]];
    [topView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [topView.layer setShadowOffset:CGSizeMake(1, 1)];
    [topView.layer setShadowOpacity:0.7f];
    [topView.layer setShadowRadius:2];
    [self addSubview:topView];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(-10, -10, 10, self.frame.size.height +20)];
    [leftView setBackgroundColor:[UIColor blackColor]];
    [leftView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [leftView.layer setShadowOffset:CGSizeMake(1, 1)];
    [leftView.layer setShadowOpacity:0.7f];
    [leftView.layer setShadowRadius:2];
    [self addSubview:leftView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, -10, 20, self.frame.size.height +20)];
    [rightView setBackgroundColor:[UIColor blackColor]];
    [rightView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [rightView.layer setShadowOffset:CGSizeMake(1, 1)];
    [rightView.layer setShadowOpacity:0.7f];
    [rightView.layer setShadowRadius:2];
    [self addSubview:rightView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(-10, self.frame.size.height, self.frame.size.width +20, 10)];
    [bottomView setBackgroundColor:[UIColor blackColor]];
    [bottomView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [bottomView.layer setShadowOffset:CGSizeMake(1, 1)];
    [bottomView.layer setShadowOpacity:0.7f];
    [bottomView.layer setShadowRadius:2];
    [self addSubview:bottomView];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
