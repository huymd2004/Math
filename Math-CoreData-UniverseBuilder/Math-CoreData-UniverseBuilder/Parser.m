//
//  Parser.m
//  Math-CoreData-UniverseBuilder
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "Parser.h"

@implementation Parser

+(void) parseUniverseWithContext:(NSManagedObjectContext *) context
{
    NSError* err = nil;
    NSString* dataPath = [[NSBundle mainBundle]
                          pathForResource:@"test" ofType:@"json"];
    NSLog(@"%@", dataPath);
    
/*    NSArray* worlds = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath]
                                                     options:kNilOptions
                                                       error:&err];
    
    NSLog(@"%@", worlds);*/
}

@end
