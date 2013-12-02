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
    
    return challenge;
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
