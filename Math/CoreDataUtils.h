//
//  CoreDataUtils.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "Profile.h"

#import "Universe.h"

#import "ProfileChallengeScore.h"

#import "ProfileWorldScore.h"

#import "Challenge.h"

#import "World.h"

@interface CoreDataUtils : NSObject
{
    NSManagedObjectContext *_managedObjectContext;
}

-(int) newProfileWithName: (NSString *) name;
-(Profile *) getCurrentProfile;
-(BOOL) canCreateNewProfile;
-(void) resetProgressForCurrentProfile;
-(NSArray *) getProfiles;
-(void) deleteProfile: (Profile *) profile;
-(void) setProfileCurrent: (Profile *) currentProfile;
-(Universe *) getUniverse;
-(ProfileChallengeScore *) getProfileChallengeScore: (Profile *) profile challenge: (Challenge *) challenge;
-(ProfileWorldScore *) getProfileWorldScore: (Profile *) profile world: (World *) world;
-(BOOL) saveProfileChallengeScore: (Profile *)
    profile withChallenge: (Challenge *) challenge andScore: (NSNumber *) score;
-(BOOL) saveProfileWorldScore: (Profile *) profile withWorld: (World *) world andScore: (NSNumber *) score;
-(void) updateChallengeForProfile: (Profile *) profile challenge: (Challenge *) challenge;
-(void) updateWorldForProfile: (Profile *) profile world: (World *) world;
-(BOOL) hasUserCompletedWorld: (Profile *) profile world: (World *) world;
-(void) setHasCompletedGame: (Profile *) profile;

+(CoreDataUtils *) getInstance;
+(void) createCoreDataWithManagedObjectContext: (NSManagedObjectContext *) managedObjectContext;

@end
