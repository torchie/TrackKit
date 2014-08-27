//
//  TKDetectorView.m
//  TrackKit
//
//  Created by Kyle Reynolds on 5/15/14.
//  Copyright (c) 2014 Kyle Reynolds. All rights reserved.
//

#import "TKDetectorView.h"
#import "TKDetectorView+regions.h"
#import "TKDetectorView+physics.h"
#import "NSTouch+physics.h"
#import <Foundation/Foundation.h>
#import "NSScreen+PointConversion.h"

@implementation TKDetectorView

- (id)initWithFrame:(NSRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:[self visibleRect] options: NSTrackingMouseEnteredAndExited |NSTrackingInVisibleRect |NSTrackingActiveAlways owner:self userInfo:nil];
        
        [self addTrackingArea:trackingArea];
        [self setNeedsDisplay:YES];
        [self setAcceptsTouchEvents:YES];
        [self setWantsRestingTouches:YES];
        [self becomeFirstResponder];
        point_size = self.frame.size.height/6;
        visible = true;
        trackpad_regions = [[NSMutableDictionary alloc] init];
        //framerelative = self.frame.origin;
        font = [NSFont fontWithName:@"Avenir Heavy" size:point_size/10];
        font_attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil, NSForegroundColorAttributeName, [NSColor whiteColor]];
        
        NSLog(@"TKDetectorView, frame rect: %@", NSStringFromRect(frame));
        num_of_drawrects = 0;
        
    }
    return self;
}
- (void)awakeFromNib {
    
}

- (void)drawRect:(NSRect)dirtyRect {
    
    //NSBezierPath* temppath
    //CGWarpMouseCursorPosition(framerelative);
    CGPoint framerelative = [self convertToScreenFromLocalPoint:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)) relativeToView:self.superview];
    CGWarpMouseCursorPosition(framerelative);
    
    
    [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    
    
    
    
    //NSLog(@"drawrect called");
    NSRect r = NSMakeRect(10, 10, 10, 10);
    NSBezierPath *bp = [NSBezierPath bezierPathWithRect:r];
    NSColor *color = [NSColor whiteColor];
    [color set];
    [bp stroke];
    
    [self verbose];
    [self drawRegions];
    [self regionIntersections];
    [super drawRect:dirtyRect];
    
	//[NSBezierPath fillRect:self.frame];
    // Drawing code here.
}


-(void)verbose {
    if(visible) {
        //REMEMBER: fast enumeration over contents of an nsdictionary requires accessing its allKeys.
        for(NSTouch* x in [touch_identities allValues]) {
            //NSLog(@"yoyoyoyoyoyo we're operating with %@ at ", x);
            CGRect to_draw = CGRectMake(x.normalizedPosition.x*self.bounds.size.width, x.normalizedPosition.y*self.bounds.size.height, point_size, point_size);
            //NSLog(@"DRAWPOINT: %@", NSStringFromRect(to_draw));
            NSBezierPath* square = [NSBezierPath bezierPath];
            [square appendBezierPathWithRect:to_draw];
            [[NSColor whiteColor] setFill];
            [[NSColor blackColor] setStroke];
            [square stroke];
            
            [[NSString stringWithFormat:@"# = %lu\n dir = %.2lfº\n avg vel = %.2lf mm/s\n, inst. vel = %.2lf mm/s",
              [[touch_identities allValues] indexOfObject:x],
              [self direction:x],
              [self velocity:x],
              [self instantaneousVelocity:x]]
             drawInRect:to_draw withAttributes:font_attributes];
        }
    }
    //[self setNeedsDisplay:YES];
    //[super setNeedsDisplay:YES];
}


-(void)mouseEntered:(NSEvent *)theEvent {
    NSLog(@"Hello!");
}

//We need a touchesBegan event for taps.
-(void)touchesBeganWithEvent:(NSEvent *)event {
    touch_identities = [[NSMutableDictionary alloc] init];
    //NSLog(@"test");
    
    for(NSTouch* touch in [event touchesMatchingPhase:NSTouchPhaseAny inView:self]) {
        //NSLog(@"touch identity%@", [touch identity]);
        //[touch phys_record];
        [touch_identities setObject:touch forKey:[touch identity]];
        //NSLog(@"all touches: %@", touch_identities);
    }
    [self phys_record];
    if(![self needsDisplay]) {
        [self setNeedsDisplay:YES];
    }
}

-(void)touchesMovedWithEvent:(NSEvent *)event {
    //Extremely slim possibility: Spacehip stopper bug is caused by the built-in trackpad having a much higher polling rate and lower latency than the magic trackpad, leading to the framerate drop seen on the magic trackpad happening so frequently on the built-in that it stops the entire game.
    //So here's what we're gonna do: to track this, we'll see the difference in touch positions list size over the same time period between the magic trackpad and built-in
    //NSLog(@"something else happened!");
    //NSLog(@"Touch detected %@", [event touchesMatchingPhase:NSTouchPhaseAny inView:self]);
    //touch_identities = [[NSMutableDictionary alloc] init];
    
   for(NSTouch* touch in [event touchesMatchingPhase:NSTouchPhaseAny inView:self]) {
        //NSLog(@"touch identity %@", [touch identity]);
        [touch_identities setObject:touch forKey:[touch identity]];
        //NSLog(@"all touches: %@", touch_identities);
    }
    //SUPER IMPORTANT THO
    [self phys_record];
   
   
    //[super setNeedsDisplay:YES];
    //[self.superview setNeedsDisplay:YES];
    if(![self needsDisplay]) {
        
        //[[self superview] setNeedsDisplay:YES];
    }
    
}


-(NSSet*)getTouches {
    //NSLog(@"Gettouches: %@", touches);
    return touches;
}

//(C) Nial Giacomelli
- (NSPoint)convertToScreenFromLocalPoint:(NSPoint)point relativeToView:(NSView *)view {
    
	NSScreen *currentScreen = [NSScreen currentScreenForMouseLocation];
	if(currentScreen)
	{
		NSPoint windowPoint = [view convertPoint:point toView:nil];
		NSPoint screenPoint = [[view window] convertBaseToScreen:windowPoint];
		NSPoint flippedScreenPoint = [currentScreen flipPoint:screenPoint];
		flippedScreenPoint.y += [currentScreen frame].origin.y;
        
		return flippedScreenPoint;
	}
	return NSZeroPoint;
}
@end
