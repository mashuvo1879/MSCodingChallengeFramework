//
//  MSCodingChallenge.m
//  MSCodingChallengeFramework
//
//  Created by Masud Shuvo on 2/18/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import "MSCodingChallenge.h"
#import "MSObjectDataService.h"
#import "MSObject.h"

@interface MSCodingChallenge ()

@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) NSMutableArray *markedFavoriteObjects;
@property (nonatomic, strong) MSObject *pickedObject;

@end

@implementation MSCodingChallenge

#pragma mark - Initialize Method
- (instancetype)initWithDelegate:(id<MSCodingChallengeDelegate>)codingChallengeDelegate
{
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray array];
        self.markedFavoriteObjects = [NSMutableArray array];
        self.delegate = codingChallengeDelegate;
    }
    return self;
}

#pragma mark - Setters and Getters
- (NSArray *)favoriteObjects
{
    return self.markedFavoriteObjects;
}

#pragma mark - methods
- (void)fetchObjects
{
    __weak MSCodingChallenge *weakSelf = self;
    [MSObjectDataService fetchObjectsWithCompletion:^(NSArray *objects, NSError *error) {
        __strong MSCodingChallenge *strongSelf = weakSelf;
        if (!error) {
            [strongSelf.objects addObjectsFromArray:objects];
            if ([strongSelf.delegate respondsToSelector:@selector(objectsReadyToPick:)]) {
                [strongSelf.delegate objectsReadyToPick:strongSelf];
            }
        }
        else {
            if ([strongSelf.delegate respondsToSelector:@selector(codingChallenge:didFailWithError:)]) {
                [strongSelf.delegate codingChallenge:strongSelf didFailWithError:error];
            }
        }
    }];
}

- (MSObject *)pickObject
{
    if ([self.objects count] > 0) {
        NSInteger randomIndex = [self randomIndexFrom:0 maxIndex:[self.objects count] - 1];
        self.pickedObject = [self.objects objectAtIndex:randomIndex];
        [self.objects removeObjectAtIndex:randomIndex];
    }
    else {
        if ([self.delegate respondsToSelector:@selector(noObjectLeftToPick:)]) {
            [self.delegate noObjectLeftToPick:self];
        }
        self.pickedObject = nil;
    }
    return self.pickedObject;
}

- (void)markObjectAsFavorite
{
    if (self.pickedObject) {
        [self.markedFavoriteObjects addObject:self.pickedObject];
    }
    self.pickedObject = nil;
}

#pragma mark - Private methods
- (NSInteger)randomIndexFrom:(NSInteger)minIndex maxIndex:(NSInteger)maxIndex
{
    return minIndex + arc4random_uniform ((uint32_t)(maxIndex - minIndex + 1));
}

@end
