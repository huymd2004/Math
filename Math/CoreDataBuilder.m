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

#import "Answer.h"

#import "CoreDataUtils.h"

#import "StringUtils.h"

@implementation CoreDataBuilder

+(void) buildWithContext: (NSManagedObjectContext *) context
{
    Universe *universe = [NSEntityDescription
                          insertNewObjectForEntityForName:@"Universe"
                          inManagedObjectContext:context];
    
    NSArray *challengeNames = [StringUtils getWorldNames];
    
    NSArray *worldNames = [StringUtils getChallengeNames];
    
    for (NSString *name in worldNames)
    {
        World *world = [self createWorld:name andContext:context andChallengeNames:challengeNames];
        world.universe = universe;
    }
}

+(World *) createWorld: (NSString *) name andContext: (NSManagedObjectContext *) context andChallengeNames: (NSArray *) challengeNames
{
    World *world = [NSEntityDescription
                          insertNewObjectForEntityForName:@"World"
                          inManagedObjectContext:context];
    
    world.name = name;
    
    for (NSString *challengeName in challengeNames)
    {
        Challenge *challenge = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Challenge"
                                inManagedObjectContext:context];
        
        challenge.name = challengeName;
        challenge.world = world;
    }
    
    return world;
}

+(BOOL) hasBuiltUniverse
{
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    
    @try {
        [coreDataUtils getUniverse];
    }
    @catch (NSException *exception) {
        return false;
    }
    
    return true;
}

+(void) buildCoreDataUniverseIfNeededWithContext: (NSManagedObjectContext *) context
{
    if (![self hasBuiltUniverse])
    {
        [self buildWithContext:context];
        
        NSError *error = nil;
        if (![context save:&error])
        {
            [NSException raise:@"Invalid core data preload."
                        format:@"%@", [error localizedDescription]];
        }
    }
}

@end
