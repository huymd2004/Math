//
//  UIUtils.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-09.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils

+(void) addBlackboardBackground: (CCScene *) scene
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *background = [CCSprite spriteWithFile:@"blackboard_background.png"];
    background.position = ccp(winSize.width/2, winSize.height/2);
    [scene addChild:background z:-1];
}

+(void) addDrawingPadBackground: (CCScene *) scene
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *background = [CCSprite spriteWithFile:@"noisy_grid.png" rect:CGRectMake(0, 0, 1536, 2048)];
    background.position = ccp(winSize.width/2, winSize.height/2);
    [scene addChild:background z:-1];
    ccTexParams repeat = {GL_LINEAR, GL_LINEAR, GL_REPEAT, GL_REPEAT};
    [background.texture setTexParameters:&repeat];
}

+(CCLabelTTF *) createGloriaHallelujahCCLabel: (int) fontSize andText: (NSString *) text
{
    CCLabelTTF *label = [self createCCLabelTTF: fontSize andText: text andFont: @"Gloria Hallelujah"];
    label.color = ccc3(0, 0, 0);
    return label;
}

+(CCLabelTTF *) createSketchCollegeCCLabel: (int) fontSize andText: (NSString *) text
{
    return [self createCCLabelTTF: fontSize andText: text andFont: @"SketchCollege"];
}

+(CCLabelTTF *) createCCLabelTTF: (int) fontSize andText: (NSString *) text andFont: (NSString *) font
{
    return [CCLabelTTF labelWithString:text fontName:font fontSize:fontSize];
}

+(void) setupDefaultBlackboardCCMenuSettings
{
    [CCMenuItemFont setFontName:@"SketchCollege"];
    [CCMenuItemFont setFontSize:26];
}

+(void) setupDefaultDrawingPadCCMenuSettings
{
    [CCMenuItemFont setFontName:@"Gloria Hallelujah"];
    [CCMenuItemFont setFontSize:40];
}

+(CCControlButton *) createBlackBoardButton: (int) fontSize andText: (NSString *) text
{
    CGRect patchRect;
    CGRect imageRect;
    if (CC_CONTENT_SCALE_FACTOR() == 2.0f)
    {
        patchRect = CGRectMake(40, 40, 270, 165);
        imageRect = CGRectMake(0, 0, 350, 245);
    }
    else
    {
        patchRect = CGRectMake(20, 20, 135, 83);
        imageRect = CGRectMake(0, 0, 175, 123);
    }
    
    CCScale9Sprite *background =
        [CCScale9Sprite spriteWithFile:@"blackboard.png" rect:patchRect capInsets:imageRect];
    
    CCLabelTTF *label = [self createSketchCollegeCCLabel:fontSize andText:text];
    label.color = ccc3(255, 255, 255);
    CCControlButton *button = [CCControlButton buttonWithLabel:label backgroundSprite:background];
    
    return button;
}

+(CCControlButton *) createBlackBoardButtonWithSize:(CGSize) size
                                            andText:(NSString *) text
                                            andFontSize: (int) fontSize
{
    CCControlButton *button = [self createBlackBoardButton:fontSize andText:text];
    [button.backgroundSprite setPreferredSize:size];
    return button;
}

@end
