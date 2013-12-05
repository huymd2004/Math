//
//  GenMathInterface.m
//  Math
//
//  Created by Johan Stenberg on 2013-12-02.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "GenMathInterface.h"

#import "GenMath.h"

#import "World.h"

#import "Universe.h"

@implementation GenMathInterface

+(NSArray *) getQuestionsForChallenge: (Challenge *) challenge
{
    World *world = challenge.world;
    Universe *universe = world.universe;
    
    int whichWorld = [universe.worlds indexOfObject:world];
    enum ProblemType problemType = [GenMath intToProblemType:whichWorld];
    
    int difficulty = [world.challenges indexOfObject:challenge] + 1;
    return [GenMath generateQuestions:problemType andDifficulty:difficulty andSize:10];
}

@end
