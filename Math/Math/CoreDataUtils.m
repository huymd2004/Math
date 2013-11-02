//
//  CoreDataUtils.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "CoreDataUtils.h"

#import "Universe.h"

#import "World.h"

#import "Challenge.h"

#import "Question.h"

#import "ProfileWorldScore.h"

#import "ProfileChallengeScore.h"

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
        [NSException raise:@"Invalid worlds fetch." format:@"%@", [error localizedDescription]];
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

@end
