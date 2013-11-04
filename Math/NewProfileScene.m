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

#define MAX_LENGTH_NAME_FIELD 10

@implementation NewProfileScene

-(id) initWithBackButtonToOptionsScene
{
    self = [self init];
    
    if (self != nil)
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCLayer *layer = [[CCLayer alloc] init];
        
        CCMenuItem *backMenuItem = [CCMenuItemFont itemWithString:@"Back" target:self
                                                         selector:(@selector(backMenuItemSelected:))];
        
        CCMenu *backMenu = [CCMenu menuWithItems:backMenuItem, nil];
        backMenu.position = ccp(winSize.width/10, winSize.height/10);
        
        [layer addChild:backMenu];
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
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Create new profile" fontName:@"SketchCollege" fontSize:24];
    label.position = ccp(winSize.width/2, (winSize.height*9)/10);
    [layer addChild:label];
    
    _nameField =
    [[UITextField alloc] initWithFrame:CGRectMake(winSize.width/2 - 100, winSize.height/5, 200,40)];
    _nameField.delegate = self;
    _nameField.placeholder = @"Enter name here!";
    _nameField.borderStyle = UITextBorderStyleRoundedRect;
    _nameField.returnKeyType = UIReturnKeyDone;
    
    [_nameField addTarget:self action:@selector(textFieldEditingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [[[CCDirector sharedDirector] view] addSubview:_nameField];
    
    CCMenuItem *finishedMenuItem = [CCMenuItemFont itemWithString:@"Done" target:self selector:(@selector(finishMenuItemSelected:))];
    
    CCMenu *finishedMenu = [CCMenu menuWithItems:finishedMenuItem, nil];
    finishedMenu.position = ccp(winSize.width/2, winSize.height/2);
    
    [layer addChild:finishedMenu];
    [self addChild:layer z:0];
}

-(void) finishMenuItemSelected:(id) sender
{
    NSString *name = _nameField.text;
    if (name.length > 0)
    {
        CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
        int result = [coreDataUtils newProfileWithName:name];
        if (result == 1)
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Taken name"
                                  message:@"There already exists a profile with that name!"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
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
                              initWithTitle:@"Please enter a name"
                              message:@"To complete your profile you must enter a name!"
                              delegate:nil
                              cancelButtonTitle:@"OK"
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
