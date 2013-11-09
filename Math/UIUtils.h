//
//  UIUtils.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-09.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "cocos2d.h"

@interface UIUtils : NSObject
+(void) addBlackboardBackground: (CCScene *) scene;
+(void) addDrawingPadBackground: (CCScene *) scene;
+(CCLabelTTF *) createGloriaHallelujahCCLabel: (int) fontSize andText: (NSString *) text;
+(CCLabelTTF *) createSketchCollegeCCLabel: (int) fontSize andText: (NSString *) text;
+(void) setupDefaultBlackboardCCMenuSettings;
+(void) setupDefaultDrawingPadCCMenuSettings;
@end
