//
//  TKDetectorView+physics.h
//  TrackKit
//
//  Created by Kyle Reynolds on 7/2/14.
//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import "TKDetectorView.h"

@interface TKDetectorView (physics)
-(void)phys_record;

-(CGFloat)deltaX:(NSTouch*)touch;
-(CGFloat)deltaY:(NSTouch*)touch;
-(CGFloat)direction:(NSTouch*)touch; //degrees are what most people think of when they think "direction"
-(CGFloat)velocity:(NSTouch*)touch; //average velocity is what most people think of when they think of "velocity"
-(CGFloat)instantaneousVelocity:(NSTouch*)touch;
-(CGFloat)acceleration:(NSTouch*)touch;

-(CGFloat)realWorldX:(NSTouch*)touch;
-(CGFloat)realWorldY:(NSTouch*)touch;

-(CGFloat)realWorldX:(CGFloat)value ofTouch:(NSTouch*)touch;
-(CGFloat)realWorldY:(CGFloat)value ofTouch:(NSTouch*)touch;

-(CGPoint)realWorldPoint:(CGPoint)value ofTouch:(NSTouch*)touch;
@end
