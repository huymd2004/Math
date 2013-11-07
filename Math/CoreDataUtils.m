//
//  CoreDataUtils.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "CoreDataUtils.h"

#import "Question.h"

#define PROFILE_LIMIT 8

@implementation CoreDataUtils

static CoreDataUtils *_coreDataUtils;

+(CoreDataUtils *) getInstance
{
    return _coreDataUtils;
}

+(void) createCoreDataWithManagedObjectContext: (NSManagedObjectContext *) managedObjectContext
{
    _coreDataUtils = [[CoreDataUtils alloc] initWithManagedObjectContext:managedObjectContext];
}

-(id) initWithManagedObjectContext:(NSManagedObjectContext *) managedObjectContext
{
    if (self = [super init])
    {
        _managedObjectContext = managedObjectContext;
        _coreDataUtils = self;
    }
    
    return self;
}

-(void) deleteProfile: (Profile *) profile
{
    [_managedObjectContext deleteObject:profile];
    
    NSError *error;
    if (![_managedObjectContext save:&error])
    {
        [NSException raise:@"Invalid delete of profile." format:@"%@", [error localizedDescription]];
    }
}

-(NSArray *) getProfiles
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Profile"
                                              inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects != nil)
    {
        return fetchedObjects;
    }
    else
    {
        [NSException raise:@"Invalid profiles fetch." format:@"%@", [error localizedDescription]];
        return nil;
    }
}

-(Universe *) getUniverse
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Universe"
                                              inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *results = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (results != nil && results.count > 0)
    {
        Universe *universe = results[0];
        return universe;
    }
    else if (results.count == 0)
    {
        [NSException raise:@"No universe found!" format:@"No universe found."];
        return nil;
    }
    else
    {
        [NSException raise:@"Invalid universe fetch." format:@"%@", [error localizedDescription]];
        return nil;
    }
}

-(Profile *) getCurrentProfile
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Profile"
                                              inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"current == YES"];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *results = [_managedObjectContext executeFetchRequest:request error:&error];
    
    if (results == nil)
    {
        [NSException raise:@"Invalid profiles fetch." format:@"%@", [error localizedDescription]];
    } else if (results.count == 0)
    {
        return nil;
    }
    
    return results[0];
}

-(int) newProfileWithName:(NSString *) name
{
    NSArray *profiles = [self getProfiles];
    for (Profile *profile in profiles)
    {
        if ([profile.name isEqualToString:name])
        {
            return 1;
        }
    }
    
    for (Profile *profile in profiles)
    {
        profile.current = [NSNumber numberWithBool:NO];
    }
    
    Universe *universe = self.getUniverse;
    
    Profile *profile = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Profile"
                        inManagedObjectContext:_managedObjectContext];

    
    profile.name = name;
    profile.world = universe.worlds[0];
    profile.challenge = profile.world.challenges[0];
    profile.current = [NSNumber numberWithBool:YES];
    
    NSError *error;
    if (![_managedObjectContext save:&error])
    {
        [NSException raise:@"Invalid profile creation." format:@"%@", [error localizedDescription]];
        return 2;
    }
    
    return 0;
}

-(BOOL) canCreateNewProfile
{
    return [self getProfiles].count < PROFILE_LIMIT;
}

-(void) setProfileCurrent: (Profile *) currentProfile
{
    NSArray *profiles = [self getProfiles];
    for (Profile *profile in profiles)
    {
        profile.current = [NSNumber numberWithBool:NO];
    }
    
    currentProfile.current = [NSNumber numberWithBool:YES];
    
    NSError *error;
    if (![_managedObjectContext save:&error])
    {
        [NSException raise:@"Invalid set to profile current." format:@"%@", [error localizedDescription]];
    }
}

-(void) resetProgressForCurrentProfile
{
    Profile *profile = [self getCurrentProfile];
    Universe *universe = self.getUniverse;
    
    profile.world = universe.worlds[0];
    profile.challenge = profile.world.challenges[0];
    
    NSSet *profileWorldScores = profile.profileWorldScores;
    NSSet *profileChallengeScores = profile.profileChallengeScores;
    
    for (ProfileWorldScore *profileWorldScore in profileWorldScores)
    {
        [_managedObjectContext deleteObject:profileWorldScore];
    }
    
    for (ProfileChallengeScore *profileChallengeScore in profileChallengeScores)
    {
        [_managedObjectContext deleteObject:profileChallengeScore];
    }
    
    NSError *error;
    if (![_managedObjectContext save:&error])
    {
        [NSException raise:@"Invalid reset." format:@"%@", [error localizedDescription]];
    }
}

-(ProfileChallengeScore *) getProfileChallengeScore: (Profile *) profile challenge: (Challenge *) challenge
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ProfileChallengeScore"
                                              inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"profile.name == %@ AND challenge.name == %@",
                              profile.name, challenge.name];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *results = [_managedObjectContext executeFetchRequest:request error:&error];
    
    if (results == nil)
    {
        [NSException raise:@"Invalid profileChallengeScore fetch."
                    format:@"%@", [error localizedDescription]];
    } else if (results.count == 0)
    {
        return nil;
    }
    
    return results[0];
}

-(ProfileWorldScore *) getProfileWorldScore: (Profile *) profile world: (World *) world
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ProfileWorldScore"
                                              inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"profile.name == %@ AND world.name == %@",
                              profile.name, world.name];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *results = [_managedObjectContext executeFetchRequest:request error:&error];
    
    if (results == nil)
    {
        [NSException raise:@"Invalid profileWorldScore fetch."
                    format:@"%@", [error localizedDescription]];
    } else if (results.count == 0)
    {
        return nil;
    }
    
    return results[0];
}

-(BOOL) saveProfileChallengeScore: (Profile *) profile withChallenge: (Challenge *) challenge andScore: (NSNumber *) score
{
    ProfileChallengeScore *oldScore =
        [self getProfileChallengeScore:profile challenge:challenge];
    
    if (oldScore == nil || score > oldScore.score)
    {
        if (oldScore != nil)
        {
            [_managedObjectContext deleteObject:oldScore];
        }
        
        ProfileChallengeScore *newScore =
            [NSEntityDescription insertNewObjectForEntityForName:@"ProfileChallengeScore"
                                           inManagedObjectContext:_managedObjectContext];
        
        newScore.profile = profile;
        newScore.score = score;
        newScore.challenge = challenge;
        
        NSError *error;
        if (![_managedObjectContext save:&error])
        {
            [NSException raise:@"Invalid challenge score save."
                        format:@"%@", [error localizedDescription]];
        }
        
        return true;
    }
    else
    {
        return false;
    }
}

-(BOOL) saveProfileWorldScore: (Profile *) profile withWorld: (World *) world andScore: (NSNumber *) score
{
    ProfileWorldScore *oldScore = [self getProfileWorldScore:profile world:world];
    
    if (oldScore == nil || score > oldScore.score)
    {
        if (oldScore != nil)
        {
            [_managedObjectContext deleteObject:oldScore];
        }
        
        ProfileWorldScore *newScore =
        [NSEntityDescription insertNewObjectForEntityForName:@"ProfileWorldScore"
                                      inManagedObjectContext:_managedObjectContext];
        
        newScore.profile = profile;
        newScore.score = score;
        newScore.world = world;
        
        NSError *error;
        if (![_managedObjectContext save:&error])
        {
            [NSException raise:@"Invalid world score save."
                        format:@"%@", [error localizedDescription]];
        }
        
        return true;
    }
    else
    {
        return false;
    }
}

-(void) updateChallengeForProfile: (Profile *) profile challenge: (Challenge *) challenge
{
    Universe *universe = [self getUniverse];
    
    int profileWorldNumber = 0;
    int profileChallengeNumber = 0;
    int worldNumber = 0;
    int challengeNumber = 0;
    for (int i = 0; i < universe.worlds.count; ++i)
    {
        World *world = universe.worlds[i];
        if ([world.name isEqualToString:profile.world.name])
        {
            profileWorldNumber = i+1;
        }
        else if ([world.name isEqualToString:challenge.world.name])
        {
            worldNumber = i+1;
        }
        
            
        for (int j = 0; j < world.challenges.count; ++j) {
            Challenge *currentChallenge = world.challenges[j];
            if ([currentChallenge.name isEqualToString:profile.challenge.name]
                && profileWorldNumber != 0 && profileChallengeNumber == 0)
            {
                profileChallengeNumber = j+1;
            }
            else if ([currentChallenge.name isEqualToString:challenge.name]
                     && worldNumber != 0 && challengeNumber == 0)
            {
                challengeNumber = j+1;
            }
        }
    }
    
    if (worldNumber > profileWorldNumber ||
        (worldNumber == profileWorldNumber && challengeNumber > profileChallengeNumber))
    {
        profile.challenge = challenge;
    
        NSError *error;
        if (![_managedObjectContext save:&error])
        {
            [NSException raise:@"Invalid profile challenge save."
                    format:@"%@", [error localizedDescription]];
        }
    }
}

-(void) updateWorldForProfile: (Profile *) profile world: (World *) world
{
    Universe *universe = [self getUniverse];
    
    int profileWorldNumber = 0;
    int worldNumber = 0;
    for (int i = 0; i < universe.worlds.count; ++i)
    {
        World *currentWorld = universe.worlds[i];
        if ([currentWorld.name isEqualToString:profile.world.name])
        {
            profileWorldNumber = i+1;
        }
        else if ([currentWorld.name isEqualToString:world.name])
        {
            worldNumber = i+1;
        }
    }
    
    if (worldNumber > profileWorldNumber)
    {
        profile.world = world;
    
        NSError *error;
        if (![_managedObjectContext save:&error])
        {
            [NSException raise:@"Invalid profile world save."
                    format:@"%@", [error localizedDescription]];
        }
    }
}

@end
