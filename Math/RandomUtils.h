//
//  RandomUtils.h
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-11-29.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RandomUtils : NSObject
+(NSArray *) randomizeUniqueHorizontalIntMatrixWithY: (int) y
                                             andX: (int) x
                                           andMin: (int) min
                                           andMax: (int) max;

+(NSArray *) randomizeUniqueHorizontalIntMatrixWithGrowingConstraintY: (int) y
                                                                 andX: (int) x
                                                               andMin: (int) min
                                                               andMax: (int) max;

+(NSArray *) randomizeUniqueIntArrayWithSize: (int) size
                           andStartValues: (NSArray *) startValues
                               andDifference: (int) diff
                                   andCentre: (int) centre
                            andCanGoNegative: (BOOL) CanGoNegative;

+(void) shuffleArray: (NSMutableArray *) array;
@end
