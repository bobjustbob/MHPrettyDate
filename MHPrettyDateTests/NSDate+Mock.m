//
//  NSDate+Mock.m
//  Whistle
//
//  Created by Justin Middleton on 7/16/13.
//  Copyright (c) 2013 whistle. All rights reserved.
//

#import "NSDate+Mock.h"
#import <objc/runtime.h>

@implementation NSDate (Mock)

static NSDate *_mockDate;

+ (void)load
{
    Method originalDate = class_getClassMethod(self, @selector(date));
    Method mockDate = class_getClassMethod(self, @selector(mockDate));
    method_exchangeImplementations(originalDate, mockDate);
}

+ (NSDate *)mockDate
{
    if (_mockDate) {
        return _mockDate;
    }
    return [self mockDate];
}

+ (void)setMockDate:(NSDate *)date
{
    _mockDate = date;
}

@end
