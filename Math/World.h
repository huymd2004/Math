//
//  World.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-04.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Challenge, Profile, ProfileWorldScore, Universe;

@interface World : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSOrderedSet *challenges;
@property (nonatomic, retain) NSSet *profile;
@property (nonatomic, retain) NSSet *profileWorldScore;
@property (nonatomic, retain) Universe *universe;
@end

@interface World (CoreDataGeneratedAccessors)

- (void)insertObject:(Challenge *)value inChallengesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromChallengesAtIndex:(NSUInteger)idx;
- (void)insertChallenges:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeChallengesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInChallengesAtIndex:(NSUInteger)idx withObject:(Challenge *)value;
- (void)replaceChallengesAtIndexes:(NSIndexSet *)indexes withChallenges:(NSArray *)values;
- (void)addChallengesObject:(Challenge *)value;
- (void)removeChallengesObject:(Challenge *)value;
- (void)addChallenges:(NSOrderedSet *)values;
- (void)removeChallenges:(NSOrderedSet *)values;
- (void)addProfileObject:(Profile *)value;
- (void)removeProfileObject:(Profile *)value;
- (void)addProfile:(NSSet *)values;
- (void)removeProfile:(NSSet *)values;

- (void)addProfileWorldScoreObject:(ProfileWorldScore *)value;
- (void)removeProfileWorldScoreObject:(ProfileWorldScore *)value;
- (void)addProfileWorldScore:(NSSet *)values;
- (void)removeProfileWorldScore:(NSSet *)values;

@end
