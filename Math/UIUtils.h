//
//  UIUtils.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-09.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "cocos2d.h"

#import "CCControlExtension.h"

enum Device
{
    iPhone,
    iPhone4,
    iPad
};

@interface UIUtils : NSObject
+(void) addBlackboardBackground: (CCScene *) scene;
+(void) addDrawingPadBackground: (CCScene *) scene;
+(CCLabelTTF *) createGloriaHallelujahCCLabel: (int) fontSize andText: (NSString *) text;
+(CCLabelTTF *) createOrangeJuiceCCLabel: (int) fontSize andText: (NSString *) text;
+(CCControlButton *) createBlackBoardButton: (int) fontSize andText: (NSString *) text;
+(CCControlButton *) createBlackBoardButtonWithSize:(CGSize) size
                                            andText:(NSString *) text
                                            andFontSize: (int) fontSize;
+(CCControlButton *) createOrangeJuiceButton: (NSString *) text;
+(CCControlButton *) createImageButton: (NSString *) imagePath;
+(CCControlButton *) createBlackBoardLabel: (int) fontSize andText: (NSString *) text;
+(CCControlButton *) createBackButton;
+(CCControlButton *) createBlackBoardBackButton;
+(CCLabelTTF *) createGloriaHallelujahTitle: (NSString *) text;
+(CCLabelTTF *) createGloriaHallelujahSubTitle: (NSString *) text;
+(CCLabelTTF *) createGloriaHallelujahSubSubTitle: (NSString *) text;
+(CCLabelTTF *) createBlackBoardTitle: (NSString *) text;
+(CCControlButton *) createDeleteButton: (int) fontSize;
+(CCControlButton *) createWrongAnswerImage;
+(enum Device) getDeviceType;
@end
