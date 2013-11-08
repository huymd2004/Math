//
//  ChallengeScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-03.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "ChallengeScene.h"

#import "CoreDataUtils.h"

#import "Profile.h"

#import "WorldScene.h"

#import "QuestionScene.h"

@implementation ChallengeScene

-(id) initWithChallenge: (Challenge *) challenge
{
    if (self = [super init])
    {
        _challenge = challenge;
        [self setupLayout:challenge];
    }
    
    return self;
}

-(void) setupLayout: (Challenge *) challenge
{
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    NSString *sceneTitleString = [NSString stringWithFormat:@"Welcome to %@", challenge.name];
    CCLabelTTF *sceneTitleLabel = [CCLabelTTF labelWithString:sceneTitleString
                                                     fontName:@"SketchCollege" fontSize:24];
    sceneTitleLabel.position = ccp(winSize.width/2, (winSize.height*9)/10);
    [layer addChild:sceneTitleLabel];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    
    ProfileChallengeScore *score = [coreDataUtils getProfileChallengeScore:profile challenge:challenge];
    
    if (score != nil)
    {
        NSString *highScoreString = [NSString stringWithFormat:@"Highscore is %@ for %@", score.score, challenge.name];
        CCLabelTTF *highScoreLabel = [CCLabelTTF labelWithString:highScoreString
                                                         fontName:@"SketchCollege" fontSize:24];
        highScoreLabel.position = ccp(winSize.width/2, (winSize.height*17)/20);
        [layer addChild:highScoreLabel];
    }
    
    CCMenuItem *playMenuItem = [CCMenuItemFont itemWithString:@"Play"
                                                        block:^(id sender) {
                                                            [self playMenuItemSelected:challenge];
                                                        }];
    
    CCMenu *playMenu = [CCMenu menuWithItems:playMenuItem, nil];
    playMenu.position = ccp(winSize.width/2, (winSize.height*3)/4);
    
    [layer addChild:playMenu];
    
    CCMenuItem *backMenuItem = [CCMenuItemFont itemWithString:@"Back"
                                                    block:^(id sender) {
                                                        [self backMenuItemSelected:challenge];
                                                    }];
    
    CCMenu *backMenu = [CCMenu menuWithItems:backMenuItem, nil];
    backMenu.position = ccp(winSize.width/10, winSize.height/10);
    
    [layer addChild:backMenu];
    [self addChild:layer];
}

-(void) playMenuItemSelected: (Challenge *) challenge
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                        transitionWithDuration:1.0 scene:[[QuestionScene alloc] initWithQuestion:challenge.questions[0] andScore:[NSNumber numberWithInt:0] andCount:1]]];
}

-(void) backMenuItemSelected: (Challenge *) challenge
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[WorldScene alloc] initWithWorld:challenge.world]]];
}

@end
