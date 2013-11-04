//
//  CoreDataBuilder.h
//  MathCoreDataBuilder
//
//  Created by Johan Stenberg on 2013-11-02.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

@interface CoreDataBuilder : NSObject
+(void) buildCoreDataUniverseIfNeededWithContext: (NSManagedObjectContext *) context;
@end
