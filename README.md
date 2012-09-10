MHPrettyDate
============

An iOS framework that provides a simple mechanism to get  "Pretty Dates" ("Yesterday", "Today", etc.) from NSDate objects.

## Public Class Methods


``` objective-c
typedef enum
{
    MHPrettyDateFormatWithTime,
    MHPrettyDateFormatNoTime
} MHPrettyDateFormat;

@interface MHPrettyDate : NSObject

+(NSString*) prettyDateFromDate:(NSDate*) date withFormat:(MHPrettyDateFormat) dateFormat;
+(BOOL)      isToday:(NSDate*)       date;
+(BOOL)      isTomorrow:(NSDate*)    date;
+(BOOL)      isYesterday:(NSDate*)   date;
+(BOOL)      isWithinWeek:(NSDate*)  date;
+(BOOL)      canMakePretty:(NSDate*) date;

@end
```

