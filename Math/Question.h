//
//  Question.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-07.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Answer, Challenge;

@interface Question : NSManagedObject

@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSString * questionImage;
@property (nonatomic, retain) NSOrderedSet *answers;
@property (nonatomic, retain) Challenge *challenge;
@end

@interface Question (CoreDataGeneratedAccessors)

- (void)insertObject:(Answer *)value inAnswersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAnswersAtIndex:(NSUInteger)idx;
- (void)insertAnswers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAnswersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAnswersAtIndex:(NSUInteger)idx withObject:(Answer *)value;
- (void)replaceAnswersAtIndexes:(NSIndexSet *)indexes withAnswers:(NSArray *)values;
- (void)addAnswersObject:(Answer *)value;
- (void)removeAnswersObject:(Answer *)value;
- (void)addAnswers:(NSOrderedSet *)values;
- (void)removeAnswers:(NSOrderedSet *)values;
@end
