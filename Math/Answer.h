//
//  Answer.h
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-11-29.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject
@property (nonatomic, retain) NSNumber * isCorrect;
@property (nonatomic, retain) NSNumber * isImage;
@property (nonatomic, retain) NSString * text;
@end
