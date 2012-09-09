//
//  MHPrettyDate.h
//  MHPrettyDate
//
//  Created by Bobby Williams on 9/8/12.
//  Copyright (c) 2012 Bobby Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    MHPrettyDateFormatWithTime,
    MHPrettyDateFormatWithoutTime
} MHPrettyDateFormat;

@interface MHPrettyDate : NSObject

+(NSString*) prettyDateFromDate:(NSDate*) date withFormat:(MHPrettyDateFormat) dateFormat;
+(BOOL)      isToday:(NSDate*)       date;
+(BOOL)      isTomorrow:(NSDate*)    date;
+(BOOL)      isYesterday:(NSDate*)   date;
+(BOOL)      isWithinWeek:(NSDate*)  date;
+(BOOL)      canMakePretty:(NSDate*) date;

@end
