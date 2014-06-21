//
//  TKDetectorView.h
//  TrackKit
//
//  Created by Kyle Reynolds on 5/15/14.
//  Copyright (c) 2014 Sky Print. All rights reserved.
//
/*
What TrackKit will do that NSTouch and UIGestureRecognizer won't:
 
 — detect movement direction in 360 degrees.
 - detect acceleration.

 - detect overlapping and crossover between user defined regions.
 
 
*/


#import <Cocoa/Cocoa.h>

@interface TKTouch: NSTouch {
    NSUInteger velocity;
    NSUInteger acceleration;
    NSUInteger direction;
    NSSet* intersected_regions;
    
    CGFloat x;
    CGFloat y;
    
    id unique_id; //Uses NSTouch identity.
    id device;
}
@end

@interface TKPad: NSObject {
    id device;
    NSSet* regions;
}
@end

@interface TKDetectorView : NSView {
    NSSet* touches; //This set is derived from the raw set coming from the OSX API.
    NSMutableDictionary* trackpad_regions;
    IBOutlet NSView* view_outlet;
    BOOL visible;
}

//@property IBOutlet NSView* view_outlet;
-(void)regionIntersections;
-(NSSet*)getTouches;
-(void)addRegion:(NSRect)userRegion withName:(NSString*)region_name; //measured in floating point from 0.0 to 1.0. Made for single-device region system.


@end
