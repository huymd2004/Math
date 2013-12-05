//
//  CCScrollLayerVertical.m
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
//  Copyright 2011 Jeff Keeme
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

#import "CCScrollLayerVertical.h"

#import "CCGL.h"

enum
{
	kCCScrollLayerStateIdle,
	kCCScrollLayerStateSliding,
};

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
@interface CCTouchDispatcher (targetedHandlersGetter)

- (id<NSFastEnumeration>) targetedHandlers;

@end

@implementation CCTouchDispatcher (targetedHandlersGetter)

- (id<NSFastEnumeration>) targetedHandlers
{
	return targetedHandlers;
}

@end
#endif

@implementation CCScrollLayerVertical

@synthesize delegate = delegate_;
@synthesize minimumTouchLengthToSlide = minimumTouchLengthToSlide_;
@synthesize marginOffset = marginOffset_;
@synthesize layer = layer_;
@synthesize stealTouches = stealTouches_;

-(id) initWithLayer:(CCLayer *) layer;
{
    if ( (self = [super init]) )
	{
		self.touchEnabled = YES;
		
		self.stealTouches = YES;
		
		self.minimumTouchLengthToSlide = 30.0f;
		
		self.marginOffset = [[CCDirector sharedDirector] winSize].height;
        
        layer.anchorPoint = ccp(0,0);
        layer.position = ccp(0, 0);

        
        [self addChild:layer];
        layer_ = layer;
	}
    
	return self;
}

- (void) dealloc
{
	self.delegate = nil;
	
	[layer_ release];
	layer_ = nil;
	
	[super dealloc];
}

#pragma mark Touches
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED

-(void) registerWithTouchDispatcher
{
#if COCOS2D_VERSION >= 0x00020000
    CCTouchDispatcher *dispatcher = [[CCDirector sharedDirector] touchDispatcher];
    int priority = kCCMenuHandlerPriority - 1;
#else
    CCTouchDispatcher *dispatcher = [CCTouchDispatcher sharedDispatcher];
    int priority = kCCMenuTouchPriority - 1;
#endif
    
	[dispatcher addTargetedDelegate:self priority: priority swallowsTouches:NO];
}

- (void) claimTouch: (UITouch *) aTouch
{
#if COCOS2D_VERSION >= 0x00020000
    CCTouchDispatcher *dispatcher = [[CCDirector sharedDirector] touchDispatcher];
#else
    CCTouchDispatcher *dispatcher = [CCTouchDispatcher sharedDispatcher];
#endif
    
	for ( CCTargetedTouchHandler *handler in [dispatcher targetedHandlers] )
	{
		if (handler.delegate == self)
		{
			if (![handler.claimedTouches containsObject: aTouch])
			{
				[handler.claimedTouches addObject: aTouch];
			}
		}
        else
        {
            if ([handler.claimedTouches containsObject: aTouch])
            {
                if ([handler.delegate respondsToSelector:@selector(ccTouchCancelled:withEvent:)])
                {
                    [handler.delegate ccTouchCancelled: aTouch withEvent: nil];
                }
                [handler.claimedTouches removeObject: aTouch];
            }
        }
	}
}

-(void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    if( scrollTouch_ == touch ) {
        scrollTouch_ = nil;
    }
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if( scrollTouch_ == nil ) {
		scrollTouch_ = touch;
	} else {
		return NO;
	}
	
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    startYPosition_ = self.position.y;
    startSwipe_ = touchPoint.y;
	state_ = kCCScrollLayerStateIdle;
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	if( scrollTouch_ != touch ) {
		return;
	}
	
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
	if ( (state_ != kCCScrollLayerStateSliding)
		&& (fabsf(touchPoint.y-startSwipe_) >= self.minimumTouchLengthToSlide) )
	{
		state_ = kCCScrollLayerStateSliding;
        
        startSwipe_ = touchPoint.y;
        startYPosition_ = self.position.y;
		
		if (self.stealTouches)
        {
			[self claimTouch: touch];
        }
		
		if ([self.delegate respondsToSelector:@selector(scrollLayerScrollingStarted:)])
		{
			[self.delegate scrollLayerScrollingStarted: self];
		}
	}
	
	if (state_ == kCCScrollLayerStateSliding)
	{
		CGFloat desiredY = (touchPoint.y - startSwipe_) + startYPosition_;
        self.position = ccp(0, desiredY);
	}
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	if( scrollTouch_ != touch )
		return;
	scrollTouch_ = nil;
    
    CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    CGFloat endPosition = layer_.contentSize.height - marginOffset_;

    CGPoint position = CGPointMake(0, self.position.y);
    if (self.position.y - endPosition > 0) {
        position.y = endPosition;
    } else if (self.position.y < 0) {
        position.y = 0;
    }
    
    id changePage = [CCMoveTo actionWithDuration:0.3 position: position];
    [self runAction:changePage];
}


#endif

@end