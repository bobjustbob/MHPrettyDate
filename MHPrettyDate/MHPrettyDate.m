//
//  MHPrettyDate.m
//  MHPrettyDate
//
//  Created by Bobby Williams on 9/8/12.
//  Copyright (c) 2012 Bobby Williams. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "MHPrettyDate.h"

@interface MHPrettyDate()

@property (strong, nonatomic)   NSDate*            today;
@property (readonly, nonatomic) NSDate*            yesterday;
@property (readonly, nonatomic) NSDate*            tomorrow;
@property (readonly, nonatomic) NSDate*            weekAgo;
@property (readonly, nonatomic) NSCalendar*        calendar;
@property (strong, nonatomic)   NSDateFormatter*   dateFormatter;
@property (assign)              MHPrettyDateFormat dateFormat;

+(MHPrettyDate*) sharedInstance;
-(NSDate* )      normalizeDate:(NSDate*) date;
-(BOOL)          isSameDay:(NSDate*) date as:(NSDate*) secondDate;

+(NSString*)     formattedStringForDate:(NSDate*) date withFormat:(MHPrettyDateFormat) dateFormat;

@end
    
@implementation MHPrettyDate

@synthesize calendar       = _calendar;
@synthesize yesterday      = _yesterday;
@synthesize tomorrow       = _tomorrow;
@synthesize weekAgo        = _weekAgo;

#pragma mark - get singleton
//
// singleton factory
//
+ (MHPrettyDate*)sharedInstance
{
    static          dispatch_once_t p           = 0;
    __strong static MHPrettyDate*   _singleton  = nil;
    
    dispatch_once(&p,
    ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

#pragma mark - worker methods

// this is a worker method
-(NSDate* ) normalizeDate:(NSDate*) date
{
    NSDateComponents* dateComponents = [self.calendar
                                        components: NSYearCalendarUnit    | NSMonthCalendarUnit | NSDayCalendarUnit |
                                        NSWeekdayCalendarUnit
                                        fromDate:  date];
    NSDate* returnDate = [self.calendar dateFromComponents:dateComponents];
    return returnDate;
}

-(BOOL) isSameDay:(NSDate*) date as:(NSDate*) secondDate
{
    NSDate* date1 = [self normalizeDate:date];
    NSDate* date2 = [self normalizeDate:secondDate];
    
    return [date1 isEqualToDate:date2];
}

+(NSString*) formattedStringForDate:(NSDate*) date withFormat:(MHPrettyDateFormat) dateFormat
{
    NSString*        dateString;
    NSDateFormatter* formatter   = [[NSDateFormatter alloc] init];
    
    //
    // TODO: this needs to be localized
    //
    if ([MHPrettyDate canMakePretty:date])
    {
        if ([MHPrettyDate isTomorrow:date])
        {
            dateString = @"'Tomorrow'";
        }
        else if ([MHPrettyDate isToday:date])
        {
            dateString = @"'Today'";
        }
        else if ([MHPrettyDate isYesterday:date])
        {
            dateString = @"'Yesterday'";
        }
        else
        {
            dateString = @"EEEE";
        }
        
        if (dateFormat == MHPrettyDateFormatWithTime)
        {
            if ([MHPrettyDate isToday:date])
            {
                dateString = @"HH:mm a";
            }
            else
            {
            dateString = [NSString stringWithFormat:@"%@ HH:mm a", dateString];
            }
        }
    }
    else
    {
        if (dateFormat == MHPrettyDateFormatWithTime)
        {
            dateString = @"MM/dd/yy HH:mm a"; // bjw bugbugbug need to localize
        }
        else
        {
            dateString = [NSDateFormatter dateFormatFromTemplate:@"MMddyy" options:0 locale:[NSLocale currentLocale]];
        }
    }
    
    [formatter setDateFormat: dateString];
    
    return [formatter stringFromDate:date];
}


#pragma mark - accessors

//
// today is read/write (write is for testing only)
//
-(NSDate*) today
{
    if (!_today)
    {
        _today = [self normalizeDate:[NSDate date]];
    }
    return _today;
}

// yesterday is today minus 1 day
-(NSDate*) yesterday
{
    if (!_yesterday)
    {
        NSDateComponents* comps = [[NSDateComponents alloc] init];
        [comps setDay: -1];
        _yesterday = [self.calendar dateByAddingComponents:comps toDate:self.today options:0];
    }
    return _yesterday;
}

// yesterday is today minus 1 day
-(NSDate*) weekAgo
{
    if (!_weekAgo)
    {
        NSDateComponents* comps = [[NSDateComponents alloc] init];
        [comps setDay: -6];
        _weekAgo = [self.calendar dateByAddingComponents:comps toDate:self.today options:0];
    }
    return _weekAgo;
}

// tomorrow is today plus 1 day
-(NSDate*) tomorrow
{
    if (!_tomorrow)
    {
        NSDateComponents* comps = [[NSDateComponents alloc] init];
        [comps setDay: 1];
        _tomorrow = [self.calendar dateByAddingComponents:comps toDate:self.today options:0];
    }
    return _tomorrow;
}

// calendar
-(NSCalendar*) calendar
{
    if (!_calendar)
    {
       _calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    }
    return _calendar;
}

// nsdateformattter
-(NSDateFormatter*) dateFormatter
{
    if (!_dateFormatter)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

#pragma mark - public methods

+(NSString*) prettyDateFromDate:(NSDate*) date withFormat:(MHPrettyDateFormat) dateFormat
{
    return [MHPrettyDate formattedStringForDate:date withFormat:dateFormat];
}

+(BOOL) isToday:(NSDate*) date
{
    MHPrettyDate* prettyDate = [MHPrettyDate sharedInstance];
    return [prettyDate isSameDay:date as:prettyDate.today];
};

+(BOOL) isTomorrow:(NSDate*) date
{
    MHPrettyDate* prettyDate = [MHPrettyDate sharedInstance];
    return [prettyDate isSameDay:date as:prettyDate.tomorrow];
};

+(BOOL) isYesterday:(NSDate*) date
{
    MHPrettyDate* prettyDate = [MHPrettyDate sharedInstance];
    return [prettyDate isSameDay:date as:prettyDate.yesterday];
};

+(BOOL) isWithinWeek:(NSDate*) date;
{
    MHPrettyDate* prettyDate   = [MHPrettyDate sharedInstance];
    NSDate*       today        = prettyDate.today;
    NSDate*       weekAgo      = prettyDate.weekAgo;
    NSDate*       testDate     = [prettyDate normalizeDate:date];
    BOOL          isWithinWeek = NO;

    if ([prettyDate isSameDay:testDate as:weekAgo] || [prettyDate isSameDay:testDate as:today])
    {
        isWithinWeek = YES;
    }
    else
    {
        NSDate* earlierDate = [testDate earlierDate: today];
        NSDate* laterDate   = [testDate laterDate:   weekAgo];
        
        isWithinWeek = ([testDate isEqualToDate:earlierDate] && [testDate isEqualToDate:laterDate]);
    }
    
    return isWithinWeek;
}

+(BOOL) canMakePretty:(NSDate *)date
{
    return ([MHPrettyDate isTomorrow:date] || [MHPrettyDate isWithinWeek:date]);
}


#pragma mark -
@end
