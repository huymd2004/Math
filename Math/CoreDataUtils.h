//
//  CoreDataUtils.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "Profile.h"

#import "Universe.h"

@interface CoreDataUtils : NSObject
{
    NSManagedObjectContext *_managedObjectContext;
}

-(int) newProfileWithName: (NSString *) name;
-(Profile *) getCurrentProfile;
-(BOOL) canCreateNewProfile;
-(void) resetProgressForCurrentProfile;
-(NSArray *) getProfiles;
-(void) deleteProfile: (Profile *) profile;
-(void) setProfileCurrent: (Profile *) currentProfile;
-(Universe *) getUniverse;

+(CoreDataUtils *) getInstance;
+(void) createCoreDataWithManagedObjectContext: (NSManagedObjectContext *) managedObjectContext;
@end
