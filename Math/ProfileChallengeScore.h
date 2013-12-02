//
//  ProfileChallengeScore.h
//  Math
//
//  Created by Johan Stenberg on 2013-12-02.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Challenge, Profile;

@interface ProfileChallengeScore : NSManagedObject

@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) Challenge *challenge;
@property (nonatomic, retain) Profile *profile;

@end
