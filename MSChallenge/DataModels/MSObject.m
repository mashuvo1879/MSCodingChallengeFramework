//
//  MSObject.m
//  MSCodingChallengeFramework
//
//  Created by Masud Shuvo on 2/18/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import "MSObject.h"
#import "MSConstant.h"
#import "MSUser.h"

@interface MSObject ()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation MSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
    }
    return self;
}

- (void)setDictionary:(NSDictionary *)dictionary
{
    self.creationInfo = dictionary[MS_CREATED] ? [self stringFromCreated:[dictionary[MS_CREATED] integerValue]] : MS_NO_ENTRY;
    self.dataType =  [self dataTypeForString:dictionary[MS_TYPE]];
    self.objectData = [self dataDetails:self.dataType dictionary:dictionary[MS_DATA]] ? : MS_NO_ENTRY;
    self.user = [[MSUser alloc] initWithDictionary:dictionary[MS_USER]];
}

- (MSDataType)dataTypeForString:(NSString *)string
{
    if (string && [string caseInsensitiveCompare:MS_TYPE_IMG] == NSOrderedSame) {
        return MSDataTypeImage;
    }
    else {
        return MSDataTypeText;
    }
}

- (NSString *)dataDetails:(MSDataType)dataType dictionary:(NSDictionary *)dictionary
{
    if (!dictionary) {
        return nil;
    }
    
    switch (dataType) {
        case MSDataTypeText:
            return dictionary[MS_TEXT];
            break;
        case MSDataTypeImage:
            return dictionary[MS_URL];
        default:
            break;
    }
}

- (NSString *)description
{
    NSDictionary *dict = @{
                           MS_CREATED : self.creationInfo,
                           MS_TYPE : @(self.dataType),
                           MS_DATA : self.objectData,
                           MS_USER : [self.user description]
                           };
    return [dict description];
}

- (NSString *)stringFromCreated:(NSInteger)created
{
    if(created > 0) {
        return MS_INVALID_DATA;
    }
    return [self relativeDateStringForDate:[NSDate dateWithTimeIntervalSinceNow:created]];
}

- (NSString *)relativeDateStringForDate:(NSDate *)date
{
    NSCalendarUnit calendarUnits = NSCalendarUnitSecond
                         | NSCalendarUnitMinute
                         | NSCalendarUnitHour
                         | NSCalendarUnitDay
                         | NSCalendarUnitWeekOfYear
                         | NSCalendarUnitMonth
                         | NSCalendarUnitYear;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:calendarUnits
                                                                   fromDate:date
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    if (components.year > 0) {
        return [NSString stringWithFormat:@"%tu years ago", components.year];
    } else if (components.month > 0) {
        return [NSString stringWithFormat:@"%tu months ago", components.month];
    } else if (components.weekOfYear > 0) {
        return [NSString stringWithFormat:@"%tu weeks ago", components.weekOfYear];
    } else if (components.day > 0) {
        return [NSString stringWithFormat:@"%tu days ago", components.day];
    } else if (components.hour > 0) {
        return [NSString stringWithFormat:@"%tu hour ago", components.hour];
    } else if (components.minute > 0) {
        return [NSString stringWithFormat:@"%tu minute ago", components.minute];
    } else if (components.second > 0) {
        return [NSString stringWithFormat:@"%tu second ago", components.second];
    } else {
        return @"just now";
    }
}

@end
