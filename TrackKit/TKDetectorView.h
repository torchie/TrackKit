//
//  TKDetectorView.h
//  TrackKit
//
//  Created by Kyle Reynolds on 5/15/14.
//  Copyright (c) 2014 Kyle Reynolds. All rights reserved.
//


#import <Cocoa/Cocoa.h>
@interface TKAction : NSObject {
    NSString* name;
    BOOL conditions;
}
-(BOOL) satisfied;
-(NSString*)name;
@end

@interface TKDetectorView : NSView {
    NSSet* touches;
    IBOutlet NSView* view_outlet;
    BOOL visible;
    CGFloat point_size;
    
    NSString* all_actions;
    NSMutableDictionary* trackpad_regions;
    NSMutableDictionary* touch_identities;
    CGPoint framerelative;
}

-(NSSet*)getTouches;
-(NSMutableDictionary*)touches;
//- (NSPoint)convertToScreenFromLocalPoint:(NSPoint)point relativeToView:(NSView *)view;

@end
