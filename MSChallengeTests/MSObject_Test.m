//
//  MSObject_Test.m
//  MSCodingChallengeFramework
//
//  Created by Masud Shuvo on 2/18/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSUser.h"
#import "MSObject.h"
#import "MSConstant.h"

@interface MSObject_Test : XCTestCase

@end

@implementation MSObject_Test

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
    
    NSString *testCreated = @"-10";
    NSString *testData = @"Technology is anything that was not around when you were born.";
    NSString *testType = @"TEXT";
    NSDictionary *dataDict = @{
                               @"text" : @"Technology is anything that was not around when you were born."
                               };
    NSDictionary *testDic = @{
                              MS_CREATED : testCreated,
                              MS_TYPE : testType,
                              MS_DATA : dataDict
                              };
    
    MSObject *testObject = [[MSObject alloc] initWithDictionary:testDic];
    XCTAssertTrue(testObject.createdTime == [testCreated integerValue], @"Wrong value");
    XCTAssertTrue([testObject.objectData isEqualToString:testData], @"Wrong value");
    XCTAssertTrue(testObject.dataType == 0, @"Wrong value");
    XCTAssertTrue([testObject.user.name isEqualToString:@""], @"Wrong value");
    XCTAssertTrue([testObject.user.country isEqualToString:@""], @"Wrong value");
}

@end
