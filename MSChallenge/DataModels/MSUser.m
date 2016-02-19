//
//  MSUser.m
//  MSCodingChallengeFramework
//
//  Created by Masud Shuvo on 2/18/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import "MSUser.h"
#import "MSConstant.h"

@interface MSUser ()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation MSUser

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
    self.name = dictionary[MS_NAME] ? : @"";
    self.country =  dictionary[MS_COUNTRY] ? : @"";
}

- (NSString *)description
{
    NSDictionary *dict = @{
                           MS_NAME: self.name,
                           MS_COUNTRY: self.country
                           };
    return [dict description];
}

@end
