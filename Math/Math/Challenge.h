//
//  Challenge.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Profile, ProfileChallengeScore, Question, World;

@interface Challenge : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *profiles;
@property (nonatomic, retain) NSOrderedSet *questions;
@property (nonatomic, retain) World *world;
@property (nonatomic, retain) NSSet *profileChallengeScores;
@end

@interface Challenge (CoreDataGeneratedAccessors)

- (void)addProfilesObject:(Profile *)value;
- (void)removeProfilesObject:(Profile *)value;
- (void)addProfiles:(NSSet *)values;
- (void)removeProfiles:(NSSet *)values;

- (void)insertObject:(Question *)value inQuestionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromQuestionsAtIndex:(NSUInteger)idx;
- (void)insertQuestions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeQuestionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInQuestionsAtIndex:(NSUInteger)idx withObject:(Question *)value;
- (void)replaceQuestionsAtIndexes:(NSIndexSet *)indexes withQuestions:(NSArray *)values;
- (void)addQuestionsObject:(Question *)value;
- (void)removeQuestionsObject:(Question *)value;
- (void)addQuestions:(NSOrderedSet *)values;
- (void)removeQuestions:(NSOrderedSet *)values;
- (void)addProfileChallengeScoresObject:(ProfileChallengeScore *)value;
- (void)removeProfileChallengeScoresObject:(ProfileChallengeScore *)value;
- (void)addProfileChallengeScores:(NSSet *)values;
- (void)removeProfileChallengeScores:(NSSet *)values;

@end
