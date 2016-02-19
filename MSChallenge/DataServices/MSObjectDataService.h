//
//  MSObjectDataService.h
//  MSCodingChallengeFramework
//
//  Created by Masud Shuvo on 2/18/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSObjectDataService : NSObject

/**
 * Fetches all objects for coding challenge.
 * @param completion Block that is called when objects have been fetched and parsed into MSObject objects or any error occurred.
 */
+ (void)fetchObjectsWithCompletion:(void (^)( NSArray *objects, NSError *error))completion;

@end
