//
//  AppDelegate.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright Johan Stenberg 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "cocos2d.h"

// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;

	CCDirectorIOS	*director_; //weak reference
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;
@property (readonly) NSManagedObjectContext *managedObjectContext;

@end
