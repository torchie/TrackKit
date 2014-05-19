//
//  TKDetectorView.m
//  TrackKit
//
//  Created by Kyle Reynolds on 5/15/14.
//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import "TKDetectorView.h"

@implementation TKDetectorView

- (id)initWithFrame:(NSRect)frame
{

    self = [super initWithFrame:frame];
    

    if (self) {
        // Initialization code here.
        NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:[self visibleRect]
                                                                    options:NSTrackingMouseEnteredAndExited | NSTrackingInVisibleRect |NSTrackingActiveAlways
                                                                      owner:self
                                                                   userInfo:nil];
        [self addTrackingArea:trackingArea];

        [self addTrackingArea:trackingArea];
        [self setAcceptsTouchEvents:YES];
        [self setWantsRestingTouches:YES];
        [self becomeFirstResponder];
    }
    return self;
}

- (void)awakeFromNib {
    NSLog(@"@im here");
	NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:[self visibleRect]
																 options:NSTrackingMouseEnteredAndExited | NSTrackingInVisibleRect |NSTrackingActiveAlways
																   owner:self
																userInfo:nil];
	
	[self addTrackingArea:trackingArea];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    [[NSColor whiteColor] set];
	[NSBezierPath fillRect:self.frame];
    // Drawing code here.
}


-(void)mouseEntered:(NSEvent *)theEvent {
    NSLog(@"Hello!");
}

-(void)touchesMovedWithEvent:(NSEvent *)event {
    
    //NSLog(@"Touch detected %@" ,[event touchesMatchingPhase:NSTouchPhaseAny inView:self]);
    touches = [event touchesMatchingPhase:NSTouchPhaseAny inView:self];
    for(NSTouch* touch in touches) {
        CGPoint relativeLocation = CGPointMake((CGFloat)[touch normalizedPosition].x /** self.bounds.size.width*/, (CGFloat)[touch normalizedPosition].y /** self.bounds.size.height*/);
        //NSLog(@"%lf, %lf",relativeLocation.x, relativeLocation.y);

        /*
        SKSpriteNode* touch_point = [SKSpriteNode spriteNodeWithImageNamed:@"Circle"];
        touch_point.position = relativeLocation;
        touch_point.scale = 0.5;
        [self addChild:touch_point];*/
    }
}

-(NSSet*)getTouches {
    //NSLog(@"Gettouches: %@", touches);
    return touches;
}

@end
