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

-(CGFloat)direction:(NSTouch*)touch;
-(CGFloat)velocity:(NSTouch*)touch;
-(CGFloat)acceleration:(NSTouch*)touch;
-(CGFloat)deltaX:(NSTouch*)touch;
-(CGFloat)deltaY:(NSTouch*)touch;
-(CGFloat)instantaneousVelocity:(NSTouch*)touch;

-(CGFloat)realWorldSize:(CGFloat)value ofTouch:(NSTouch*)touch;
@end
