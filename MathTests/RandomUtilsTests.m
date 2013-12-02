//
//  RandomUtilsTests.m
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-11-30.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RandomUtils.h"

#import "Answer.h"

@interface RandomUtilsTests : XCTestCase

@end

@implementation RandomUtilsTests

- (void) testRandomizeUniqueHorizontalIntMatrix
{
    int x = 10;
    int y = 10;
    int min = 0;
    int max = 10;
    
    NSArray *matrix = [RandomUtils randomizeUniqueHorizontalIntMatrixWithY:y
                                            andX:x andMin:min andMax:max];
    
    for (int i = 0; i < [matrix count]; ++i)
    {
        if (i != 0)
        {
            for (int j = 0; j < i; ++j)
            {
                XCTAssertFalse([matrix[i] isEqualToArray:matrix[j]],
                              @"Matrix not horizontally unique!");
                
                for (int k = 0; k < [matrix[i] count]; ++k)
                {
                    XCTAssertTrue([matrix[i][k] intValue] >= min && [matrix[i][k] intValue] <= max,
                        @"Matrix element outside bounds!");
                }
            }
        }
        
        XCTAssertTrue([matrix[i] count] == x, @"Wrong matrix horizontal size!");
    }
    
    XCTAssertTrue([matrix count] == y, @"Wrong matrix vertical size!");
}

- (void) testRandomizeUniqueHorizontalIntMatrixWithGrowingConstraintY
{
    int x = 10;
    int y = 10;
    int min = 0;
    int max = 10;
    
    NSArray *matrix = [RandomUtils randomizeUniqueHorizontalIntMatrixWithGrowingConstraintY:y
                                                                      andX:x andMin:min andMax:max];
    
    for (int i = 0; i < [matrix count]; ++i)
    {
        if (i != 0)
        {
            for (int j = 0; j < i; ++j)
            {
                XCTAssertFalse([matrix[i] isEqualToArray:matrix[j]],
                               @"Matrix not horizontally unique!");
            }
            
            for (int j = 0; j < [matrix[i] count]; ++j)
            {
                XCTAssertTrue([matrix[i][j] intValue] >= min && [matrix[i][j] intValue] <= max,
                              @"Matrix element outside bounds!");
                
                if (j > 0)
                {
                    XCTAssertTrue([matrix[i][j] intValue] >= [matrix[i][j-1] intValue], @"Not growing constraint matrix!");
                }
            }
        }
        
        XCTAssertTrue([matrix[i] count] == x, @"Wrong matrix horizontal size!");
    }
    
    XCTAssertTrue([matrix count] == y, @"Wrong matrix vertical size!");
}

- (void) testRandomizeUniqueIntArrayWithSizeAndCanGoNegativeNO
{
    int size = 20;
    int max = 20;
    
    NSArray *startValues = [[NSArray alloc] initWithObjects:0, 1, 2, 3, nil];
    
    
    NSArray *array = [RandomUtils randomizeUniqueIntArrayWithSize:size
                                                   andStartValues:startValues
                                                    andDifference:max
                                                        andCentre:max/2
                                                 andCanGoNegative:NO];
    
    XCTAssertTrue([array count] == size, @"Wrong array size!");
    
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (int i = 0; i < size; ++i)
    {
        XCTAssertFalse([set containsObject:array[i]], @"Not unique array!");
        [set addObject:array[i]];
        
        XCTAssertTrue([array[i] intValue] <= max && [array[i] intValue] >= 0,
                      @"Array element outside bounds!");
    }
}

- (void) testRandomizeUniqueIntArrayWithSizeAndCanGoNegativeYES
{
    {
        int size = 20;
        int max = 20;
        
        NSArray *startValues = [[NSArray alloc] initWithObjects:0, 1, 2, 3, nil];
        
        
        NSArray *array = [RandomUtils randomizeUniqueIntArrayWithSize:size
                                                       andStartValues:startValues
                                                        andDifference:max
                                                            andCentre:0
                                                     andCanGoNegative:YES];
        
        XCTAssertTrue([array count] == size, @"Wrong array size!");
        
        NSMutableSet *set = [[NSMutableSet alloc] init];
        for (int i = 0; i < size; ++i)
        {
            XCTAssertFalse([set containsObject:array[i]], @"Not unique array!");
            [set addObject:array[i]];
            
            XCTAssertTrue([array[i] intValue] <= max/2 && [array[i] intValue] >= -(max/2),
                          @"Array element outside bounds!");
        }
    }
}

- (void) testShuffleArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100; ++i)
    {
        array[i] = [[NSNumber alloc] initWithInt:i+1];
    }
    
    NSArray *copyBefore = [[NSArray alloc] initWithArray:array];
    
    BOOL hasChanged = NO;
    for (int i = 0; i < 10; ++i)
    {
        [RandomUtils shuffleArray:array];
        NSArray *copy = [[NSArray alloc] initWithArray:array];
        if (![copyBefore isEqualToArray:copy])
        {
            hasChanged = YES;
            break;
        }
    }
    
    XCTAssertTrue(hasChanged, @"Array hasn't been shuffled!");
}

@end
