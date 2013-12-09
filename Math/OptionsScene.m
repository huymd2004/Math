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

#import "StringUtils.h"

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
    
    CCLabelTTF *label = [UIUtils createGloriaHallelujahTitle:[StringUtils getOptionsString]];
    [layer addChild:label];
    
    CCControlButton *manageProfilesButton =
        [UIUtils createBlackBoardButton:40 andText:[StringUtils getManageProfilesString]];
    manageProfilesButton.position = ccp(winSize.width/2, (winSize.height*3)/5);
    
    [manageProfilesButton addTarget:self
                   action:@selector(manageProfilesButtonSelected:)
         forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:manageProfilesButton];
    
    CCControlButton *resetProgressButton =
    [UIUtils createBlackBoardButton:40 andText:[StringUtils getResetProgressString]];
    resetProgressButton.position = ccp(winSize.width/2, (winSize.height*7)/15);
    
    [resetProgressButton addTarget:self
                             action:@selector(resetProgressButtonSelected:)
                   forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:resetProgressButton];
    
    CCControlButton *newProfileButton =
    [UIUtils createBlackBoardButton:40 andText:[StringUtils getNewProfileString]];
    newProfileButton.position = ccp(winSize.width/2, (winSize.height)/3);
    
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
    
    NSString *alertViewMessage = [StringUtils getRestProgressMessage:profile.name];
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:[StringUtils getResetProgressString]
                                                      message:alertViewMessage
                                                     delegate:self
                                            cancelButtonTitle:[StringUtils getNoString]
                                            otherButtonTitles:[StringUtils getYesString], nil];
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
                              initWithTitle:[StringUtils getTooManyProfilesTitle]
                              message:[StringUtils getTooManyProfilesMessage]
                              delegate:nil
                              cancelButtonTitle:[StringUtils getOKString]
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
