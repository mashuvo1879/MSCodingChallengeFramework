//
//  MSUser_Test.m
//  MSCodingChallengeFramework
//
//  Created by Masud Shuvo on 2/18/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSConstant.h"
#import "MSUser.h"

@interface MSUser_Test : XCTestCase

@end

@implementation MSUser_Test

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitWithDictionary
{
    NSString *testName = @"xyz";
    NSString *testCountry = @"abc";
    
    
    NSDictionary *testDic = @{
                              MS_NAME : testName,
                              MS_COUNTRY : testCountry,
                            };
    
    MSUser *testUser = [[MSUser alloc] initWithDictionary:testDic];
    
    XCTAssertTrue([testUser.name isEqual:testName],@"wrong value");
    XCTAssertTrue([testUser.country isEqual:testCountry],@"wrong value");
}

@end
