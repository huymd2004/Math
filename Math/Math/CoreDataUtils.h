//
//  CoreDataUtils.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "Profile.h"

@interface CoreDataUtils : NSObject
{
    NSManagedObjectContext *_managedObjectContext;
}

-(int) newProfileWithName:(NSString *) name;
-(Profile *) getCurrentProfile;

+(CoreDataUtils *) getInstance;
+(void) createCoreDataWithManagedObjectContext: (NSManagedObjectContext *) managedObjectContext;
@end
