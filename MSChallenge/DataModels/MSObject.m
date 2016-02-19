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
    self.createdTime = [dictionary[MS_CREATED] integerValue];
    self.dataType =  [self dataTypeForString:dictionary[MS_TYPE]];
    self.objectData = [self dataDetails:self.dataType dictionary:dictionary[MS_DATA]] ? : @"";
    self.user = [[MSUser alloc] initWithDictionary:dictionary[MS_USER]];
}

- (MSDataType)dataTypeForString:(NSString *)string
{
    if ([string isEqualToString:MS_TYPE_IMG]) {
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
                           MS_CREATED : @(self.createdTime),
                           MS_TYPE : @(self.dataType),
                           MS_DATA : self.objectData,
                           MS_USER : [self.user description]
                           };
    return [dict description];
}

@end
