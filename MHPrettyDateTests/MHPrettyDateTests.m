//
//  MHPrettyDateTests.m
//  MHPrettyDateTests
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

#import "MHPrettyDateTests.h"
#import "MHPrettyDate.h"
#import "NSDate+Mock.h"

//@implementation MHPrettyDate (Testing)
//@end

static NSCalendar* __sCalendar;

@implementation MHPrettyDateTests

- (void)setUp
{
    [super setUp];
    
    __sCalendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    __sCalendar = nil;
    
    [super tearDown];
}

- (void) printDate:(NSDate*) compareDate
{
//   NSLog(@"Pretty date with time is %@", [MHPrettyDate prettyDateFromDate:compareDate withFormat:MHPrettyDateFormatWithTime]);
//   NSLog(@"Pretty date without time is %@", [MHPrettyDate prettyDateFromDate:compareDate withFormat:MHPrettyDateFormatNoTime]);
//   NSLog(@"Pretty date with long time is %@", [MHPrettyDate prettyDateFromDate:compareDate withFormat: MHPrettyDateLongFormatWithTime]);

   NSLog(@"Pretty date long relative time is %@", [MHPrettyDate prettyDateFromDate:compareDate withFormat: MHPrettyDateLongRelativeTime]);
   NSLog(@"Pretty date short relative time is %@", [MHPrettyDate prettyDateFromDate:compareDate withFormat: MHPrettyDateShortRelativeTime]);
}

- (void)testCompareToday
{
    NSDate* compareDate = [NSDate date];
    
    NSLog(@"now is %@", compareDate);
    
    STAssertTrue([MHPrettyDate isToday:compareDate], nil);
    STAssertFalse([MHPrettyDate isTomorrow: compareDate], nil);
    STAssertFalse([MHPrettyDate isYesterday: compareDate], nil);
    STAssertTrue([MHPrettyDate willMakePretty:compareDate], nil);
   
   [self printDate: compareDate];
}

- (void)testCompareTomorrow
{
    NSDate* now = [NSDate date];
    
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    [comps setDay: 1];
    NSDate* compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
   
    NSLog(@"tomorrow is %@", compareDate);
    
    STAssertFalse([MHPrettyDate isToday:compareDate], nil);
    STAssertTrue([MHPrettyDate isTomorrow: compareDate], nil);
    STAssertFalse([MHPrettyDate isYesterday: compareDate], nil);
    STAssertTrue([MHPrettyDate willMakePretty:compareDate], nil);
    STAssertTrue([MHPrettyDate isFutureDate:compareDate], nil);
    STAssertFalse([MHPrettyDate isPastDate:compareDate], nil);
   
   [self printDate: compareDate];
}

- (void)testCompareOverDateChange
{
    NSDate* now = [NSDate date];
    
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    [comps setDay: 1];
    NSDate* compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
    
    NSLog(@"tomorrow is %@", compareDate);
    
    STAssertFalse([MHPrettyDate isToday:compareDate], nil);
    STAssertTrue([MHPrettyDate isTomorrow: compareDate], nil);
    STAssertFalse([MHPrettyDate isYesterday: compareDate], nil);
    STAssertTrue([MHPrettyDate willMakePretty:compareDate], nil);
    STAssertTrue([MHPrettyDate isFutureDate:compareDate], nil);
    STAssertFalse([MHPrettyDate isPastDate:compareDate], nil);

    // Bump the current date.

    [NSDate setMockDate:compareDate];
    
    STAssertTrue([MHPrettyDate isToday:compareDate], nil);
    STAssertFalse([MHPrettyDate isTomorrow: compareDate], nil);
    STAssertFalse([MHPrettyDate isYesterday: compareDate], nil);
    STAssertTrue([MHPrettyDate willMakePretty:compareDate], nil);
    STAssertFalse([MHPrettyDate isFutureDate:compareDate], nil);
    STAssertFalse([MHPrettyDate isPastDate:compareDate], nil);

    [NSDate setMockDate:[__sCalendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];

    // Bump it again.

    STAssertFalse([MHPrettyDate isToday:compareDate], nil);
    STAssertFalse([MHPrettyDate isTomorrow: compareDate], nil);
    STAssertTrue([MHPrettyDate isYesterday: compareDate], nil);
    STAssertTrue([MHPrettyDate willMakePretty:compareDate], nil);
    STAssertFalse([MHPrettyDate isFutureDate:compareDate], nil);
    STAssertTrue([MHPrettyDate isPastDate:compareDate], nil);
    
    [NSDate setMockDate:nil];
}

- (void)testCompareYesterday
{
    NSDate* now = [NSDate date];
    
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    [comps setDay: -1];
    NSDate* compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
    
    NSLog(@"yesterday is %@", compareDate);
    
    STAssertFalse([MHPrettyDate isToday:compareDate], nil);
    STAssertFalse([MHPrettyDate isTomorrow: compareDate], nil);
    STAssertTrue([MHPrettyDate isYesterday: compareDate], nil);
    STAssertTrue([MHPrettyDate willMakePretty:compareDate], nil);
    STAssertFalse([MHPrettyDate isFutureDate:compareDate], nil);
    STAssertTrue([MHPrettyDate isPastDate:compareDate], nil);
   
   [self printDate: compareDate];
}

- (void)testCompareWithinWeek
{
    NSDate* now = [NSDate date];
    
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    
    NSInteger dateOffset;
    for (dateOffset = 0; dateOffset > -7; dateOffset--)
    {
       [comps setDay: dateOffset];
       NSDate* compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
    
       NSLog(@"weekday is %@", compareDate);
        
        STAssertTrue([MHPrettyDate isWithinWeek:compareDate], nil);
        STAssertTrue([MHPrettyDate willMakePretty:compareDate], nil);
        
       [self printDate: compareDate];
    }
    
    // future
    dateOffset = 1; // tomorrow
    [comps setDay: dateOffset];
    NSDate* compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
    NSLog(@"tomorrow is %@", compareDate);
    STAssertFalse([MHPrettyDate isWithinWeek:compareDate], nil);
    STAssertTrue([MHPrettyDate willMakePretty:compareDate], nil);
    
   [self printDate: compareDate];

    dateOffset = 8;
    [comps setDay: dateOffset];
    compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
    NSLog(@"future is %@", compareDate);
    STAssertFalse([MHPrettyDate isWithinWeek:compareDate], nil);
    STAssertFalse([MHPrettyDate willMakePretty:compareDate], nil);
    
   [self printDate: compareDate];
   
    // past
    dateOffset = -7;
    [comps setDay: dateOffset];
    compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
    NSLog(@"past is %@", compareDate);
    STAssertFalse([MHPrettyDate isWithinWeek:compareDate], nil);
    STAssertFalse([MHPrettyDate willMakePretty:compareDate], nil);
    
   [self printDate: compareDate];
   
    dateOffset = -30;
    [comps setDay: dateOffset];
    compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
    NSLog(@"way past is %@", compareDate);
    STAssertFalse([MHPrettyDate isWithinWeek:compareDate], nil);
    STAssertFalse([MHPrettyDate willMakePretty:compareDate], nil);
    
   [self printDate: compareDate];
}


- (void)testCompareMinutesAgo
{
   NSDate* now = [NSDate date];
   
   NSDateComponents* comps = [[NSDateComponents alloc] init];
   [comps setMinute: -15];
   NSDate* compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
   
   NSLog(@"15 minutes ago is %@", compareDate);
   
   [self printDate: compareDate];
}


- (void)testCompareHoursAgo
{
   NSDate* now = [NSDate date];
   
   NSDateComponents* comps = [[NSDateComponents alloc] init];
   [comps setHour: -15];
   NSDate* compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
   
   NSLog(@"15 hours ago is %@", compareDate);
   
   [self printDate: compareDate];
}


@end
