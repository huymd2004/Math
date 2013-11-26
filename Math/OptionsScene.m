//
//  OptionsScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-02.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "OptionsScene.h"

#import "ManageProfilesScene.h"

#import "NewProfileScene.h"

#import "CoreDataUtils.h"

#import "MainMenuScene.h"

#import "UIUtils.h"

@implementation OptionsScene

-(id) init
{
    if (self = [super init])
    {
        [self setupLayout];
    }
    
    return self;
}

-(void) setupLayout
{
    [UIUtils addDrawingPadBackground:self];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    CCLabelTTF *label = [UIUtils createGloriaHallelujahCCLabel:56 andText:@"Options"];
    label.position = ccp(winSize.width/2, (winSize.height*4)/5);
    [layer addChild:label];
    
    CCMenuItem *manageProfilesMenuItem = [CCMenuItemFont itemWithString:@"Manage profiles" target:self
                                                     selector:(@selector(manageProfileMenuItemSelected:))];
    
    CCMenuItem *resetProgressMenuItem = [CCMenuItemFont itemWithString:@"Reset progress" target:self
                                                        selector:(@selector(resetProgressMenuItemSelected:))];
    
    CCMenuItem *newProfileMenuItem = [CCMenuItemFont itemWithString:@"New profile" target:self
                                                        selector:(@selector(newProfileMenuItemSelected:))];
    
    CCMenu *menu = [CCMenu menuWithItems:manageProfilesMenuItem,
                    resetProgressMenuItem, newProfileMenuItem, nil];
    [menu alignItemsVertically];
    menu.position = ccp(winSize.width/2, winSize.height/2);
    [layer addChild:menu];
    
    [UIUtils setupDefaultDrawingPadCCMenuSettings];
    
    CCMenuItem *backMenuItem = [CCMenuItemFont itemWithString:@"<" target:self
                                                     selector:(@selector(backMenuItemSelected:))];
    [backMenuItem setColor:ccc3(1, 1, 1)];
    CCMenu *backMenu = [CCMenu menuWithItems:backMenuItem, nil];
    backMenu.position = ccp(winSize.width/10, winSize.height/10);
    [layer addChild:backMenu];
    
    [self addChild:layer];
}

-(void) manageProfileMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[ManageProfilesScene alloc] init]]];
}

-(void) resetProgressMenuItemSelected:(id) sender
{
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    Profile *profile = [coreDataUtils getCurrentProfile];
    
    NSString *alertViewMessage = @"Are you sure you want to reset progress for ";
    alertViewMessage = [alertViewMessage stringByAppendingString:profile.name];
    alertViewMessage = [alertViewMessage stringByAppendingString:@"?"];
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Reset progress"
                                                      message:alertViewMessage
                                                     delegate:self
                                            cancelButtonTitle:@"No"
                                            otherButtonTitles:@"Yes", nil];
    [message show];
}

-(void) alertView: (UIAlertView *) alert clickedButtonAtIndex: (NSInteger) buttonIndex
{
    if(buttonIndex == 1)
    {
        CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
        [coreDataUtils resetProgressForCurrentProfile];
    }
}

-(void) newProfileMenuItemSelected:(id) sender
{
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    
    if ([coreDataUtils canCreateNewProfile])
    {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[NewProfileScene alloc] initWithBackButtonToOptionsScene]]];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Already max profiles"
                              message:@"To delete a profile press \"Manage Profiles\"!"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void) backMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init]]];
}

@end
