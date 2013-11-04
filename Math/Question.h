//
//  Question.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-04.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Answer, Challenge;

@interface Question : NSManagedObject

@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSString * questionImage;
@property (nonatomic, retain) NSOrderedSet *answer;
@property (nonatomic, retain) Challenge *challenge;
@end

@interface Question (CoreDataGeneratedAccessors)

- (void)insertObject:(Answer *)value inAnswerAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAnswerAtIndex:(NSUInteger)idx;
- (void)insertAnswer:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAnswerAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAnswerAtIndex:(NSUInteger)idx withObject:(Answer *)value;
- (void)replaceAnswerAtIndexes:(NSIndexSet *)indexes withAnswer:(NSArray *)values;
- (void)addAnswerObject:(Answer *)value;
- (void)removeAnswerObject:(Answer *)value;
- (void)addAnswer:(NSOrderedSet *)values;
- (void)removeAnswer:(NSOrderedSet *)values;
@end
