//
//  CoreDataBuilder.m
//  MathCoreDataBuilder
//
//  Created by Johan Stenberg on 2013-11-02.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "CoreDataBuilder.h"

#import "Universe.h"

#import "World.h"

#import "Challenge.h"

#import "Question.h"

@implementation CoreDataBuilder

+(void) buildWithContext: (NSManagedObjectContext *) context
{
    NSError *err = nil;
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Universe" ofType:@"json"];
    NSArray *worldDictionaries = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath] options:kNilOptions error:&err];
    
    Universe *universe = [NSEntityDescription
                          insertNewObjectForEntityForName:@"Universe"
                          inManagedObjectContext:context];
    
    for (NSString *worldName in worldDictionaries)
    {
        NSString *worldDataPath = [[NSBundle mainBundle] pathForResource:worldName ofType:@"json"];
        NSDictionary *worldDictionary = [NSJSONSerialization JSONObjectWithData:
                          [NSData dataWithContentsOfFile:worldDataPath]
                                                            options:NSJSONReadingMutableContainers
                                                           error:&err];
        
        World *world = [self createWorldFromDictionary:worldDictionary andContext:context];
        world.universe = universe;
    }
}
    
+(World *) createWorldFromDictionary: (NSDictionary *) worldDictionary
                          andContext: (NSManagedObjectContext *) context
{
    World *world = [NSEntityDescription
                    insertNewObjectForEntityForName:@"World"
                    inManagedObjectContext:context];
    
    NSString *name = [worldDictionary objectForKey:@"name"];
    world.name = name;
    
    NSArray *challengeDictionaries = [worldDictionary objectForKey:@"challenges"];
    
    for (NSDictionary *challengeDictionary in challengeDictionaries)
    {
        Challenge *challenge = [self createChallengeFromDictionary:challengeDictionary
                                                        andContext:context];
        challenge.world = world;
    }
    
    return world;
}
    
+(Challenge *) createChallengeFromDictionary: (NSDictionary *) challengeDictionary andContext: (NSManagedObjectContext *) context
{
    Challenge *challenge = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Challenge"
                            inManagedObjectContext:context];
    
    NSString *name = [challengeDictionary objectForKey:@"name"];
    challenge.name = name;
    challenge.questions = [[NSOrderedSet alloc] init];
    
    NSArray *questionDictionaris = [challengeDictionary objectForKey:@"questions"];
    
    for (NSDictionary *questionDictionary in questionDictionaris)
    {
        Question *question = [self createQuestionFromDictionary:questionDictionary
                                                        andContext:context];
        question.challenge = challenge;
    }
    
    return challenge;
}
    
+(Question *) createQuestionFromDictionary: (NSDictionary *) questionDictionary andContext: (NSManagedObjectContext *) context
{
    Question *question = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Question"
                            inManagedObjectContext:context];
    
    question.isAnswersImages = [questionDictionary objectForKey:@"isAnswersImages"];
    question.correctAnswer = [questionDictionary objectForKey:@"correctAnswer"];
    question.firstAnswer = [questionDictionary objectForKey:@"firstAnswer"];
    question.secondAnswer = [questionDictionary objectForKey:@"secondAnswer"];
    question.thirdAnswer = [questionDictionary objectForKey:@"thirdAnswer"];
    question.fourthAnswer = [questionDictionary objectForKey:@"fourthAnswer"];
    question.question = [questionDictionary objectForKey:@"question"];
    
    id questionImage = [questionDictionary objectForKey:@"questionImage"];
    if (questionImage == [NSNull null])
    {
        question.questionImage = nil;
    }
    else
    {
        question.questionImage = (NSString *) questionImage;
    }
    
    return question;
}

@end
