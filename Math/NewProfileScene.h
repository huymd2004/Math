//
//  NewProfileScene.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "cocos2d.h"

@interface NewProfileScene : CCScene <UITextFieldDelegate>
{
    UITextField *_nameField;
}
-(id) initWithBackButtonToOptionsScene;
@end
