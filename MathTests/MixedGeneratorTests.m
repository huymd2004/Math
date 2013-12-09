//
//  MixedGeneratorTests.m
//  Math
//
//  Created by Johan Stenberg on 2013-12-09.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "AbstractGeneratorTests.h"

@interface MixedGeneratorTests : AbstractGeneratorTests
{
    enum ProblemType problemType;
}
@end

@implementation MixedGeneratorTests

- (void)setUp
{
    problemType = Mixed;
    [super setUp];
}

-(void) testGenerateQuestionsForDifficultyOne
{
    [super testGenerateQuestionsForDifficultyOneOrSix:problemType andDifficulty:1];
}

-(void) testGenerateQuestionsForDifficultyTwo
{
    [super testGenerateQuestionsForDifficultyTwoOrSeven:problemType andDifficulty:2];
}

-(void) testGenerateQuestionsForDifficultyThree
{
    [super testGenerateQuestionsForDifficultyThreeOrEight:problemType andDifficulty:3];
}

-(void) testGenerateQuestionsForDifficultyFour
{
    [super testGenerateQuestionsForDifficultyFourFiveNineOrTen:problemType andDifficulty:4];
}

-(void) testGenerateQuestionsForDifficultyFive
{
    [super testGenerateQuestionsForDifficultyFourFiveNineOrTen:problemType andDifficulty:5];
}

-(void) testGenerateQuestionsForDifficultySix
{
    [super testGenerateQuestionsForDifficultyOneOrSix:problemType andDifficulty:6];
}

-(void) testGenerateQuestionsForDifficultySeven
{
    [super testGenerateQuestionsForDifficultyTwoOrSeven:problemType andDifficulty:7];
}

-(void) testGenerateQuestionsForDifficultyEight
{
    [super testGenerateQuestionsForDifficultyThreeOrEight:problemType andDifficulty:8];
}

-(void) testGenerateQuestionsForDifficultyNine
{
    [super testGenerateQuestionsForDifficultyFourFiveNineOrTen:problemType andDifficulty:9];
}

-(void) testGenerateQuestionsForDifficultyTen
{
    [super testGenerateQuestionsForDifficultyFourFiveNineOrTen:problemType andDifficulty:10];
}

@end
