//
//  ManageProfilesScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-02.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "ManageProfilesScene.h"

#import "OptionsScene.h"

#import "CoreDataUtils.h"

#import "UIUtils.h"

#import "StringUtils.h"

@implementation ManageProfilesScene

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
    
    CCLabelTTF *label = [UIUtils createGloriaHallelujahTitle:[StringUtils getManageProfilesString]];
    [layer addChild:label];
    
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    NSArray *profiles = [coreDataUtils getProfiles];
    
    CCControlButton *profilesTitleLabel = [UIUtils createBlackBoardLabel:28 andText:[StringUtils getNumberOfProfilesString:profiles.count]];
    profilesTitleLabel.position = ccp(winSize.width/2, (winSize.height*7)/10);
    [layer addChild:profilesTitleLabel];
    
    CCControlButton *nameLabel = [UIUtils createBlackBoardLabel:28 andText:[StringUtils getNameWithColonString]];
    nameLabel.position = ccp((winSize.width*3)/10, (winSize.height*6)/10);
    [layer addChild:nameLabel];
    
    CCControlButton *currentLabel = [UIUtils createBlackBoardLabel:28 andText:[StringUtils getCurrentWithColonString]];
    currentLabel.position = ccp((winSize.width*7)/10, (winSize.height*6)/10);
    [layer addChild:currentLabel];
    
    NSMutableArray *radioMenuItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < profiles.count; ++i)
    {
        Profile *profile = profiles[i];
        
        CCControlButton *profileNameLabel = [UIUtils createBlackBoardLabel:28 andText:profile.name];
        profileNameLabel.position = ccp((winSize.width*3)/10, (winSize.height*(41 - 7*i))/80);
        [layer addChild:profileNameLabel];
        
        CCMenuItemFont *radioMenuItem = [CCMenuItemFont itemWithString:@"[ ]"
                                            block:^(CCMenuItemFont *sender) {
                                                for (CCMenuItemFont *menuItem in radioMenuItems)
                                                {
                                                    [menuItem setIsEnabled:YES];
                                                    [menuItem setString:@"[ ]"];
                                                    menuItem.color = ccc3(0, 0, 0);
                                                }
                                                
                                                [sender setIsEnabled:NO];
                                                [sender setString:@"[x]"];
                                                    
                                                [coreDataUtils setProfileCurrent:profile];
                                            }];
        
        
        radioMenuItem.color = ccc3(0, 0, 0);
        radioMenuItem.disabledColor = ccc3(0, 0, 0);
        [radioMenuItems addObject:radioMenuItem];
        
        if ([profile.current intValue] == 1)
        {
            [radioMenuItem setIsEnabled:NO];
            [radioMenuItem setString:@"[x]"];
        }
        
        CCMenu *radioMenu = [CCMenu menuWithItems:radioMenuItem, nil];
        radioMenu.position = ccp((winSize.width*7)/10, (winSize.height*(41 - 7*i))/80);
        [layer addChild:radioMenu];
        
        CCControlButton *deleteProfileButton = [UIUtils createDeleteButton:32];
        
        [deleteProfileButton setBlock:^(id sender, CCControlEvent event)
        {
            [self showDeleteProfileDialogForProfile:profile];
        } forControlEvents:CCControlEventTouchUpInside];
        
        deleteProfileButton.position = ccp((winSize.width*17)/20, (winSize.height*(41 - 7*i))/80);
        [layer addChild:deleteProfileButton];
    }
    
    CCControlButton *backButton = [UIUtils createBackButton];
    
    [backButton addTarget:self
                   action:@selector(backMenuItemSelected:)
         forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:backButton];
    [self addChild:layer];
}

-(void) showDeleteProfileDialogForProfile: (Profile *) profile
{
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    Profile *currentProfile = [coreDataUtils getCurrentProfile];
    
    if ([profile.name isEqualToString:currentProfile.name])
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:[StringUtils getCantDeleteProfileStringTitle:profile.name]
                              message:[StringUtils getCantDeleteProfileStringMessage:profile.name]
                              delegate:nil
                              cancelButtonTitle:[StringUtils getOKString]
                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[StringUtils getDeleteProfileTitle]
                                                          message:[StringUtils getDeleteProfileMessage:profile.name]
                                                         delegate:self
                                                cancelButtonTitle:[StringUtils getNoString]
                                                otherButtonTitles:[StringUtils getYesString], nil];
        
        [alertView show];
    }
}

-(void) alertView: (UIAlertView *) alert clickedButtonAtIndex: (NSInteger) buttonIndex
{
    if(buttonIndex == 1)
    {
        CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
        [coreDataUtils deleteProfile:_profileToBeDeleted];
        _profileToBeDeleted = nil;
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                    transitionWithDuration:1.0 scene:[[ManageProfilesScene alloc] init]]];
    }
}

-(void) backMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                transitionWithDuration:1.0 scene:[[OptionsScene alloc] init]]];
}

@end
