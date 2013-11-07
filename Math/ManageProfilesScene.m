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
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:@"Manage profiles"
                                           fontName:@"SketchCollege" fontSize:24];
    titleLabel.position = ccp(winSize.width/2, (winSize.height*9)/10);
    [layer addChild:titleLabel];
    
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    NSArray *profiles = [coreDataUtils getProfiles];
    
    NSString *profilesString = @"You have ";
    profilesString = [profilesString stringByAppendingString:
                      [NSString stringWithFormat:@"%i", profiles.count]];
    profilesString =
        [profilesString stringByAppendingString:profiles.count > 1 ? @" profiles!" : @" profile!"];
    
    CCLabelTTF *profilesLabel = [CCLabelTTF labelWithString:profilesString
                                           fontName:@"SketchCollege" fontSize:24];
    profilesLabel.position = ccp(winSize.width/2, (winSize.height*8)/10);
    [layer addChild:profilesLabel];
    
    CCLabelTTF *nameLabel = [CCLabelTTF labelWithString:@"Name"
                                                   fontName:@"SketchCollege" fontSize:24];
    nameLabel.position = ccp((winSize.width*2)/5, (winSize.height*3)/4);
    [layer addChild:nameLabel];
    
    CCLabelTTF *currentLabel = [CCLabelTTF labelWithString:@"Current"
                                               fontName:@"SketchCollege" fontSize:24];
    currentLabel.position = ccp((winSize.width*3)/5, (winSize.height*3)/4);
    [layer addChild:currentLabel];
    
    NSMutableArray *radioMenuItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < profiles.count; ++i)
    {
        Profile *profile = profiles[i];
        NSString *name = profile.name;
        
        CCLabelTTF *profileNameLabel = [CCLabelTTF labelWithString:name
                                                   fontName:@"SketchCollege" fontSize:24];
        profileNameLabel.position = ccp((winSize.width*2)/5, (winSize.height*(13 - i))/20);
        [layer addChild:profileNameLabel];
        
        CCMenuItem *radioMenuItem = [CCMenuItemFont itemWithString:@"Current"
                                            block:^(CCMenuItem *sender) {
                                                for (CCMenuItem *menuItem in radioMenuItems)
                                                {
                                                    [menuItem setIsEnabled:YES];
                                                }
                                                
                                                [sender setIsEnabled:NO];
                                                    
                                                [coreDataUtils setProfileCurrent:profile];
                                            }];
        
        [radioMenuItems addObject:radioMenuItem];
        
        if ([profile.current intValue] == 1)
        {
            [radioMenuItem setIsEnabled:NO];
        }
        
        CCMenu *radioMenu = [CCMenu menuWithItems:radioMenuItem, nil];
        radioMenu.position = ccp((winSize.width*3)/5, (winSize.height*(13 - i))/20);
        [layer addChild:radioMenu];
        
        CCMenuItem *deleteProfileMenuItem = [CCMenuItemFont itemWithString:@"Delete"
                                            block:^(id sender) {
                                              [self showDeleteProfileDialogForProfile:profile];
                                            }];
        
        CCMenu *deleteProfileMenu = [CCMenu menuWithItems:deleteProfileMenuItem, nil];
        deleteProfileMenu.position = ccp((winSize.width*4)/5, (winSize.height*(13 - i))/20);
        [layer addChild:deleteProfileMenu];
    }
    
    CCMenuItem *backMenuItem = [CCMenuItemFont itemWithString:@"Back" target:self
                                                     selector:(@selector(backMenuItemSelected:))];
    
    CCMenu *backMenu = [CCMenu menuWithItems:backMenuItem, nil];
    backMenu.position = ccp(winSize.width/10, winSize.height/10);
    
    [layer addChild:backMenu];
    [self addChild:layer];
}

-(void) showDeleteProfileDialogForProfile: (Profile *) profile
{
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    Profile *currentProfile = [coreDataUtils getCurrentProfile];
    
    if ([profile.name isEqualToString:currentProfile.name])
    {
        NSString *title = @"Can't delete ";
        title = [title stringByAppendingString:profile.name];
        
        NSString *message = profile.name;
        message = [message stringByAppendingString:@" is your current profile!"];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        _profileToBeDeleted = profile;
        NSString *message = @"Are you sure you want to delete the profile ";
        message = [message stringByAppendingString:profile.name];
        message = [message stringByAppendingString:@"?"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure?"
                                                          message:message
                                                         delegate:self
                                                cancelButtonTitle:@"No"
                                                otherButtonTitles:@"Yes", nil];
        
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
