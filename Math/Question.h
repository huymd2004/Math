//
//  Question.h
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-11-29.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
@property (nonatomic, retain) NSString *question;
@property (nonatomic, retain) NSString *questionImage;
@property (nonatomic, retain) NSArray *answers;
@end
