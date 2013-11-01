//
//  Question.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Challenge;

@interface Question : NSManagedObject

@property (nonatomic, retain) NSNumber * correctAnswer;
@property (nonatomic, retain) NSString * firstAnswer;
@property (nonatomic, retain) NSString * fourthAnswer;
@property (nonatomic, retain) NSNumber * isAnswersImages;
@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSString * questionImage;
@property (nonatomic, retain) NSString * secondAnswer;
@property (nonatomic, retain) NSString * thirdAnswer;
@property (nonatomic, retain) Challenge *challenge;

@end
