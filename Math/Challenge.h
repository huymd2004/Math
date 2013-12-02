//
//  Challenge.h
//  Math
//
//  Created by Johan Stenberg on 2013-12-02.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Profile, ProfileChallengeScore, World;

@interface Challenge : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *profileChallengeScores;
@property (nonatomic, retain) NSSet *profiles;
@property (nonatomic, retain) World *world;
@end

@interface Challenge (CoreDataGeneratedAccessors)

- (void)addProfileChallengeScoresObject:(ProfileChallengeScore *)value;
- (void)removeProfileChallengeScoresObject:(ProfileChallengeScore *)value;
- (void)addProfileChallengeScores:(NSSet *)values;
- (void)removeProfileChallengeScores:(NSSet *)values;

- (void)addProfilesObject:(Profile *)value;
- (void)removeProfilesObject:(Profile *)value;
- (void)addProfiles:(NSSet *)values;
- (void)removeProfiles:(NSSet *)values;

@end
