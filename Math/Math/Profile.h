//
//  Profile.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Challenge, ProfileChallengeScore, ProfileWorldScore, World;

@interface Profile : NSManagedObject

@property (nonatomic, retain) NSNumber * current;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Challenge *challenge;
@property (nonatomic, retain) NSSet *profileChallengeScores;
@property (nonatomic, retain) NSSet *profileWorldScores;
@property (nonatomic, retain) World *world;
@end

@interface Profile (CoreDataGeneratedAccessors)

- (void)addProfileChallengeScoresObject:(ProfileChallengeScore *)value;
- (void)removeProfileChallengeScoresObject:(ProfileChallengeScore *)value;
- (void)addProfileChallengeScores:(NSSet *)values;
- (void)removeProfileChallengeScores:(NSSet *)values;

- (void)addProfileWorldScoresObject:(ProfileWorldScore *)value;
- (void)removeProfileWorldScoresObject:(ProfileWorldScore *)value;
- (void)addProfileWorldScores:(NSSet *)values;
- (void)removeProfileWorldScores:(NSSet *)values;

@end
