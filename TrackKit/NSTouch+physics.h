//
//  NSTouch+physics.h
//  TrackKit
//
//  Created by Kyle Reynolds on 6/30/14.
//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTouch () {
    NSMutableArray* previous_positions;
}
@property NSMutableArray* previous_positions;
-(void)phys_record;

-(CGFloat)direction;
-(CGFloat)velocity;
-(CGFloat)acceleration;
-(CGFloat)deltaX;
-(CGFloat)deltaY;
-(CGFloat)instantaneousVelocity;
@end
