//
//  AbstractGeneratorTests.h
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-12-02.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//


#import <XCTest/XCTest.h>

#import "GenMath.h"

@interface AbstractGeneratorTests : XCTestCase

- (void) testGenerateQuestionsForDifficultyOneOrSix: (enum ProblemType) problemType andDifficulty: (int) difficulty;
- (void) testGenerateQuestionsForDifficultyTwoOrSeven: (enum ProblemType) problemType andDifficulty: (int) difficulty;
- (void) testGenerateQuestionsForDifficultyThreeOrEight: (enum ProblemType) problemType andDifficulty: (int) difficulty;
- (void) testGenerateQuestionsForDifficultyFourFiveNineOrTen: (enum ProblemType) problemType andDifficulty: (int) difficulty;

@end
