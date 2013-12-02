//
//  Answer.m
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-11-29.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "Answer.h"

@implementation Answer

- (BOOL) isEqual:(id) other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    Answer *otherAnswer = (Answer *) other;
    
    return [otherAnswer.text isEqualToString:self.text]
        && [otherAnswer.isCorrect isEqualToNumber:self.isCorrect]
        && [otherAnswer.isImage isEqualToNumber:self.isImage];
}

@end
