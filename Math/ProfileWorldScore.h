//
//  ProfileWorldScore.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-04.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Profile, World;

@interface ProfileWorldScore : NSManagedObject

@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) Profile *profile;
@property (nonatomic, retain) World *world;

@end
