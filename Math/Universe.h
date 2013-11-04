//
//  Universe.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-04.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class World;

@interface Universe : NSManagedObject

@property (nonatomic, retain) NSOrderedSet *worlds;
@end

@interface Universe (CoreDataGeneratedAccessors)

- (void)insertObject:(World *)value inWorldsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromWorldsAtIndex:(NSUInteger)idx;
- (void)insertWorlds:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeWorldsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInWorldsAtIndex:(NSUInteger)idx withObject:(World *)value;
- (void)replaceWorldsAtIndexes:(NSIndexSet *)indexes withWorlds:(NSArray *)values;
- (void)addWorldsObject:(World *)value;
- (void)removeWorldsObject:(World *)value;
- (void)addWorlds:(NSOrderedSet *)values;
- (void)removeWorlds:(NSOrderedSet *)values;
@end
