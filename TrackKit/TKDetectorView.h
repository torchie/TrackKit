//
//  TKDetectorView.h
//  TrackKit
//
//  Created by Kyle Reynolds on 5/15/14.
//  Copyright (c) 2014 Kyle Reynolds. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface TKDetectorView : NSView {
    NSSet* touches;
    NSMutableDictionary* trackpad_regions;
    IBOutlet NSView* view_outlet;
    BOOL visible;
    NSMutableDictionary* touch_identities;
    CGPoint framerelative;
}

-(void)regionIntersections;
-(NSSet*)getTouches;
-(NSMutableDictionary*)touches;
-(void)addRegion:(NSRect)userRegion withName:(NSString*)region_name;
- (NSPoint)convertToScreenFromLocalPoint:(NSPoint)point relativeToView:(NSView *)view;

@end
