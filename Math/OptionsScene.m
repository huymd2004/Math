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
    
    CCLabelTTF *label = [UIUtils createGloriaHallelujahTitle:@"Options"];
    [layer addChild:label];
    
    CCControlButton *manageProfilesButton =
        [UIUtils createBlackBoardButton:30 andText:@"Manage profiles"];
    manageProfilesButton.position = ccp(winSize.width/2, (winSize.height*3)/5);
    
    [manageProfilesButton addTarget:self
                   action:@selector(manageProfilesButtonSelected:)
         forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:manageProfilesButton];
    
    CCControlButton *resetProgressButton =
    [UIUtils createBlackBoardButton:30 andText:@"Reset progress"];
    resetProgressButton.position = ccp(winSize.width/2, (winSize.height)/2);
    
    [resetProgressButton addTarget:self
                             action:@selector(resetProgressButtonSelected:)
                   forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:resetProgressButton];
    
    CCControlButton *newProfileButton =
    [UIUtils createBlackBoardButton:30 andText:@"New profile"];
    newProfileButton.position = ccp(winSize.width/2, (winSize.height*2)/5);
    
    [newProfileButton addTarget:self
                            action:@selector(newProfileButtonSelected:)
                  forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:newProfileButton];
    
    CCControlButton *backButton = [UIUtils createBackButton];
    
    [backButton addTarget:self
                         action:@selector(backMenuItemSelected:)
               forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:backButton];
    
    [self addChild:layer];
}

-(void) manageProfilesButtonSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[ManageProfilesScene alloc] init]]];
}

-(void) resetProgressButtonSelected:(id) sender
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

-(void) newProfileButtonSelected:(id) sender
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
