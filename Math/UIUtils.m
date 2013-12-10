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

+(CCLabelTTF *) createOrangeJuiceCCLabel: (int) fontSize andText: (NSString *) text
{
    return [self createCCLabelTTF: fontSize andText: text andFont: @"orangejuice"];
}

+(CCLabelTTF *) createCCLabelTTF: (int) fontSize andText: (NSString *) text andFont: (NSString *) font
{
    return [CCLabelTTF labelWithString:text fontName:font fontSize:fontSize];
}

+(CCControlButton *) createBlackBoardButton: (int) fontSize andText: (NSString *) text
{
    CGRect patchRect = CGRectMake(20, 20, 135, 83);
    CGRect imageRect = CGRectMake(0, 0, 175, 123);
    
    CCScale9Sprite *background =
        [CCScale9Sprite spriteWithFile:@"blackboard.png" rect:patchRect capInsets:imageRect];
    
    CCLabelTTF *label = [self createOrangeJuiceCCLabel:fontSize andText:text];
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
    button.preferredSize = size;
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
        [CCControlButton buttonWithTitle:@"<" fontName:@"orangejuice" fontSize:64];
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

+(CCControlButton *) createWrongAnswerImage
{
    CCControlButton *image = [self createDeleteButton:120];
    image.enabled = NO;
    return image;
}

+(CCLabelTTF *) createBlackBoardTitle: (NSString *) text
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *label = [UIUtils createOrangeJuiceCCLabel:30 andText:text];
    label.position = ccp(winSize.width/2, (winSize.height*4)/5);
    return label;
}

+(CCControlButton *) createOrangeJuiceButton: (NSString *) text
{
    CCControlButton *button =
    [CCControlButton buttonWithTitle:text fontName:@"orangejuice" fontSize:56];
    button.color = ccc3(255, 255, 255);
    [button setTitleColor:button.color forState:CCControlEventTouchDown];
    return button;
}

+(CCControlButton *) createImageButton: (NSString *) imagePath
{
    CCScale9Sprite *sprite = [CCScale9Sprite spriteWithFile:imagePath ];
    CCControlButton *button = [CCControlButton buttonWithBackgroundSprite:sprite];
    button.adjustBackgroundImage = NO;
    return button;
}

@end
