//
//  NewProfileScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "NewProfileScene.h"

#import "MainMenuScene.h"

#import "CoreDataUtils.h"

#import "OptionsScene.h"

#import "UIUtils.h"

#import "StringUtils.h"

#define MAX_LENGTH_NAME_FIELD 10

@implementation NewProfileScene

-(id) initWithBackButtonToOptionsScene
{
    self = [self init];
    
    if (self != nil)
    {
        CCLayer *layer = [[CCLayer alloc] init];
        
        CCControlButton *backButton = [UIUtils createBackButton];
        
        [backButton addTarget:self
                       action:@selector(backMenuItemSelected:)
             forControlEvents:CCControlEventTouchDown];
        
        [layer addChild:backButton];
        
        [self addChild:layer z:1];
    }
    
    return self;
}

-(void) backMenuItemSelected:(id) sender
{
    [_nameField removeFromSuperview];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                transitionWithDuration:1.0 scene:[[OptionsScene alloc] init]]];
}

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
    
    CCLabelTTF *label = [UIUtils createGloriaHallelujahTitle:[StringUtils getCreateNewProfileTitle]];
    [layer addChild:label];
    
    _nameField =
    [[UITextField alloc] initWithFrame:CGRectMake(winSize.width/2 - 100, winSize.height/3, 200,40)];
    _nameField.delegate = self;
    _nameField.placeholder = [StringUtils getCreatenewProfileInputPlaceHolder];
    _nameField.borderStyle = UITextBorderStyleRoundedRect;
    _nameField.returnKeyType = UIReturnKeyDone;
    
    [_nameField addTarget:self action:@selector(textFieldEditingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5f * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        [[[CCDirector sharedDirector] view] addSubview:_nameField];
    });
    
    CCControlButton *doneButton = [UIUtils createBlackBoardButton:40 andText:[StringUtils getDoneString]];
    doneButton.position = ccp(winSize.width/2, (winSize.height)/2);
    
    [doneButton addTarget:self
                   action:@selector(doneButtonSelected:)
         forControlEvents:CCControlEventTouchDown];
    
    [layer addChild:doneButton];
    
    [self addChild:layer z:0];
}

-(void) doneButtonSelected:(id) sender
{
    NSString *name = _nameField.text;
    if (name.length > 0)
    {
        CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
        int result = [coreDataUtils newProfileWithName:name];
        if (result == 1)
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:[StringUtils getTakenNameTitle]
                                  message:[StringUtils getTakenNameMessage]
                                  delegate:nil
                                  cancelButtonTitle:[StringUtils getOKString]
                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            [_nameField removeFromSuperview];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                                       transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init]]];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:[StringUtils getNothingEnteredNewProfileNameTitle]
                              message:[StringUtils getNothingEnteredNewProfileNameMessage]
                              delegate:nil
                              cancelButtonTitle:[StringUtils getOKString]
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= MAX_LENGTH_NAME_FIELD || returnKey;
}

-(void) textFieldEditingDidEndOnExit:(UITextField*) textField { }

@end
