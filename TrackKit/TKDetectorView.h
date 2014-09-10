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
    BOOL visible;
    //CGPoint framerelative;
    CGFloat point_size;
    NSUInteger num_of_drawrects;
    NSSet* touches;
    IBOutlet NSView* view_outlet;
    
    NSFont* font;
    NSString* all_actions;
    
    NSDictionary* font_attributes;
    NSMutableDictionary* trackpad_regions;
    NSMutableDictionary* touch_identities;
    NSMutableDictionary* touch_positions;
    NSMutableDictionary* touch_times;
}

-(NSSet*)getTouches;
-(NSMutableDictionary*)touches;
-(NSPoint)convertToScreenFromLocalPoint:(NSPoint)point relativeToView:(NSView *)view;

//Basic methods for getting touch physics information to controller delegates.
-(BOOL)isBeingTouched;
-(BOOL)hasNumberOfTouchings:(NSUInteger)userNumber;
-(NSTouch*)firstFinger;
-(NSTouch*)fingerNumber:(NSUInteger)userFingerNumber;

-(NSTouch*)firstFling;
@end
