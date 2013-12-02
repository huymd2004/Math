//
//  RandomUtils.m
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-11-29.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "RandomUtils.h"

#import "Answer.h"

@implementation RandomUtils

+(NSArray *) randomizeUniqueHorizontalIntMatrixWithY: (int) y
                                             andX: (int) x
                                           andMin: (int) min
                                           andMax: (int) max
{
    NSMutableArray *matrix = [[NSMutableArray alloc] initWithCapacity:y];
    for (int i = 0; i < y; ++i)
    {
        NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity:x];
        
        do
        {
            for (int j = 0; j < x; ++j)
            {
                row[j] = [NSNumber numberWithInt:arc4random() % (max - min + 1) + min];
            }
        }
        while ([self isHorizontallyTaken:matrix andRow:row]);
        
        matrix[i] = [row copy];
    }
    
    return [matrix copy];
}

+(NSArray *) randomizeUniqueHorizontalIntMatrixWithGrowingConstraintY: (int) y
                                                                 andX: (int) x
                                                               andMin: (int) min
                                                               andMax: (int) max
{
    NSMutableArray *matrix = [[NSMutableArray alloc] initWithCapacity:y];
    for (int i = 0; i < y; ++i)
    {
        NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity:x];
        
        do
        {
            for (int j = 0; j < x; ++j)
            {
                int tmpMin = min;
                if (j > 0)
                {
                    tmpMin = [row[j-1] intValue];
                }
                
                row[j] = [NSNumber numberWithInt:arc4random() % (max - tmpMin + 1) + tmpMin];
            }
        }
        while ([self isHorizontallyTaken:matrix andRow:row]);
        
        matrix[i] = [row copy];
    }
    
    return [matrix copy];
}


+(BOOL) isHorizontallyTaken: (NSMutableArray *) matrix andRow: (NSMutableArray *) row
{
    for (int i = 0; i < [matrix count]; ++i)
    {
        if ([matrix[i] isEqualToArray:row])
        {
            return YES;
        }
    }
    
    return NO;
}

+(NSArray *) randomizeUniqueIntArrayWithSize: (int) size
                              andStartValues: (NSArray *) startValues
                               andDifference: (int) diff
                                   andCentre: (int) centre
                            andCanGoNegative: (BOOL) CanGoNegative
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:startValues];
    int base = (centre - diff/2);
    if (!CanGoNegative && (centre - diff/2) < 0)
    {
        base = 0;
    }

    for (int i = (int) [array count]; i < size; ++i)
    {
        int value = 0;
        do
        {

            value = arc4random() % (diff + 1) + base;
        }
        while (![self isUnique:value andArray:array]);
        
        array[i] = [NSNumber numberWithInt:value];
    }
    
    return [array copy];
}

+(BOOL) isUnique: (int) value andArray: (NSArray *) array
{
    for (int i = 0; i < [array count]; ++i)
    {
        if (value == [array[i] intValue])
        {
            return NO;
        }
    }
    
    return YES;
}

+(void) shuffleArray: (NSMutableArray *) array
{
    for (NSUInteger i = 0; i < [array count]; ++i) {
        [array exchangeObjectAtIndex:i
                   withObjectAtIndex:arc4random() % ([array count] - i) + i];
    }
}

@end
