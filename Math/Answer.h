//
//  Answer.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-04.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Question;

@interface Answer : NSManagedObject

@property (nonatomic, retain) NSNumber * isCorrect;
@property (nonatomic, retain) NSNumber * isImage;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Question *question;

@end
