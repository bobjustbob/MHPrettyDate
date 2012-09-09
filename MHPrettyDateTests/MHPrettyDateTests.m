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

- (void)testCompareToday
{
    NSDate* compareDate = [NSDate date];
    
    NSLog(@"now is %@", compareDate);
    
    STAssertTrue([MHPrettyDate isToday:compareDate], nil);
    STAssertFalse([MHPrettyDate isTomorrow: compareDate], nil);
    STAssertFalse([MHPrettyDate isYesterday: compareDate], nil);
    STAssertTrue([MHPrettyDate canMakePretty:compareDate], nil);
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
    STAssertTrue([MHPrettyDate canMakePretty:compareDate], nil);
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
    STAssertTrue([MHPrettyDate canMakePretty:compareDate], nil);
}

- (void)testCompareWithinWeek
{
    NSDate* now = [NSDate date];
    
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    
    NSInteger dateOffset;
    for (dateOffset = 0; dateOffset > -8; dateOffset--)
    {
       [comps setDay: dateOffset];
       NSDate* compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
    
       NSLog(@"weekday is %@", compareDate);
        
        STAssertTrue([MHPrettyDate isWithinWeek:compareDate], nil);
        STAssertTrue([MHPrettyDate canMakePretty:compareDate], nil);
    }
    
    // future
    dateOffset = 1; // tomorrow
    [comps setDay: dateOffset];
    NSDate* compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
    NSLog(@"future is %@", compareDate);
    STAssertFalse([MHPrettyDate isWithinWeek:compareDate], nil);
    STAssertTrue([MHPrettyDate canMakePretty:compareDate], nil);

    dateOffset = 8;
    [comps setDay: dateOffset];
    compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
    NSLog(@"future is %@", compareDate);
    STAssertFalse([MHPrettyDate isWithinWeek:compareDate], nil);
    STAssertFalse([MHPrettyDate canMakePretty:compareDate], nil);
    
    // past
    dateOffset = -8;
    [comps setDay: dateOffset];
    compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
    NSLog(@"past is %@", compareDate);
    STAssertFalse([MHPrettyDate isWithinWeek:compareDate], nil);
    STAssertFalse([MHPrettyDate canMakePretty:compareDate], nil);
    
    dateOffset = -30;
    [comps setDay: dateOffset];
    compareDate = [__sCalendar dateByAddingComponents:comps toDate:now options:0];
    NSLog(@"past is %@", compareDate);
    STAssertFalse([MHPrettyDate isWithinWeek:compareDate], nil);
    STAssertFalse([MHPrettyDate canMakePretty:compareDate], nil);
}


@end
