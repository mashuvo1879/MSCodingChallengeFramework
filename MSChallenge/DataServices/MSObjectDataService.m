//
//  MSObjectDataService.m
//  MSCodingChallengeFramework
//
//  Created by Masud Shuvo on 2/18/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import "MSObjectDataService.h"
#import "MSObject.h"

static NSString *const codingChallengeApiUrl = @"https://private-d847e-demoresponse.apiary-mock.com/questions";

@implementation MSObjectDataService

+ (void)fetchObjectsWithCompletion:(void (^)( NSArray *objects, NSError *error))completion {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:codingChallengeApiUrl]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
        
        NSError *jsonError;
        NSArray *objectArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        
        if(jsonError)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, jsonError);
            });
            return;
        }

        NSMutableArray *mutableAdArray = [[NSMutableArray alloc] init];
        
        [objectArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MSObject *object = [[MSObject alloc] initWithDictionary:obj];
            [mutableAdArray addObject:object];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(mutableAdArray, nil);
        });
    }];
    [task resume];
}

@end
