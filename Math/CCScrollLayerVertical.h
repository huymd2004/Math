//
//  CCScrollLayerVertical.h
//
//  Copyright 2013 Johan Stenberg
//
//  Copyright 2010 DK101
//  http://dk101.net/2010/11/30/implementing-page-scrolling-in-cocos2d/
//
//  Copyright 2010 Giv Parvaneh.
//  http://www.givp.org/blog/2010/12/30/scrolling-menus-in-cocos2d/
//
//  Copyright 2011-2012 Stepan Generalov
//  Copyright 2011 Brian Feller
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class CCScrollLayerVertical;
@protocol CCScrollLayerVerticalDelegate

@optional

- (void) scrollLayerScrollingStarted:(CCScrollLayerVertical *) sender;

@end

@interface CCScrollLayerVertical : CCLayer
{
	NSObject <CCScrollLayerVerticalDelegate> *delegate_;
	
	CGFloat startSwipe_;
    
    CGFloat startYPosition_;
	
	CGFloat minimumTouchLengthToSlide_;
    
    NSTimeInterval timestampTouchStarted_;
	
	int state_;
	
	BOOL stealTouches_;
	
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
	UITouch *scrollTouch_;
#endif
    
	CGFloat marginOffset_;
}

@property (readwrite, assign) NSObject <CCScrollLayerVerticalDelegate> *delegate;

#pragma mark Scroll Config Properties

@property(readwrite, assign) CGFloat minimumTouchLengthToSlide;

@property(readwrite, assign) CGFloat  marginOffset;

@property(readwrite) BOOL stealTouches;


#pragma mark Pages Control Properties

@property(readonly) CCLayer *layer;

-(id) initWithLayer:(CCLayer *) layer;

@end
