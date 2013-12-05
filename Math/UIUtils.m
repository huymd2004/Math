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

+(CCControlButton *) createBackButton
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCControlButton *button =
        [CCControlButton buttonWithTitle:@"<" fontName:@"Gloria Hallelujah" fontSize:48];
    button.color = ccc3(0, 0, 0);
    button.position = ccp(winSize.width/10, winSize.height/12);
    return button;
}

+(CCControlButton *) createBlackBoardBackButton
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCControlButton *button =
        [CCControlButton buttonWithTitle:@"<" fontName:@"SketchCollege" fontSize:64];
    button.position = ccp(winSize.width/10, winSize.height/12);
    return button;
}

+(CCLabelTTF *) createGloriaHallelujahTitle: (NSString *)text
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *label = [UIUtils createGloriaHallelujahCCLabel:56 andText:text];
    label.position = ccp(winSize.width/2, (winSize.height*4)/5);
    return label;
}

+(CCLabelTTF *) createGloriaHallelujahSubTitle: (NSString *) text
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *label = [UIUtils createGloriaHallelujahCCLabel:30 andText:text];
    label.position = ccp(winSize.width/2, (winSize.height*7)/10);
    return label;
}

+(CCLabelTTF *) createGloriaHallelujahSubSubTitle: (NSString *) text
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *label = [self createGloriaHallelujahSubTitle:text];
    label.position = ccp(winSize.width/2, (winSize.height*3)/5);
    return label;
}

+(CCControlButton *) createBlackBoardLabel: (int) fontSize andText: (NSString *) text
{
    CCControlButton *label = [UIUtils createBlackBoardButton:fontSize andText:text];
    label.enabled = NO;
    return label;
}

+(CCControlButton *) createDeleteButton: (int) fontSize
{
    CCControlButton *button =
        [CCControlButton buttonWithTitle:@"X" fontName:@"Gloria Hallelujah" fontSize:fontSize];
    button.color = ccc3(255, 0, 0);
    [button setTitleColor:button.color forState:CCControlEventTouchDown];
    return button;
}

+(CCLabelTTF *) createBlackBoardTitle: (NSString *) text
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *label = [UIUtils createSketchCollegeCCLabel:30 andText:text];
    label.position = ccp(winSize.width/2, (winSize.height*4)/5);
    return label;
}

+(CCControlButton *) createSketchCollegeButton: (NSString *) text
{
    CCControlButton *button =
    [CCControlButton buttonWithTitle:text fontName:@"SketchCollege" fontSize:56];
    button.color = ccc3(255, 255, 255);
    [button setTitleColor:button.color forState:CCControlEventTouchDown];
    return button;
}

+(CCControlButton *) createAnswerImageButton: (NSString *) imagePath
{
    CCScale9Sprite *sprite = [CCScale9Sprite spriteWithFile:imagePath ];
    CCControlButton *button = [CCControlButton buttonWithBackgroundSprite:sprite];
    button.adjustBackgroundImage = NO;
    return button;
}

@end
