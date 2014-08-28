//
//  TKDetectorView+physics.m
//  TrackKit
//
//  Created by Kyle Reynolds on 7/2/14.
//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import "TKDetectorView+physics.h"
#include <mach/mach.h>
#include <math.h>
#include <CoreServices/CoreServices.h>
@implementation TKDetectorView (physics)
-(void) phys_record {

    //if list of positions for touches doesn't exist, create
    if(!touch_positions){
        touch_positions = [[NSMutableDictionary alloc] init];
    }
    if(!touch_times) {
        touch_times = [[NSMutableDictionary alloc] init];
    }
    for(NSTouch* x in [touch_identities allValues]) {
        //if there is no touch position array for the touch , create one
        if(![touch_positions objectForKey:[x identity]]) {
            NSMutableArray* positions = [[NSMutableArray alloc] init];
            NSMutableArray* times = [[NSMutableArray alloc] init];
            
            [positions addObject:[NSValue valueWithPoint:x.normalizedPosition]];
            [times addObject:[NSNumber numberWithDouble:CACurrentMediaTime()]];
            
            [touch_positions setObject:positions forKey:[x identity]];
            [touch_times setObject:times forKey:[x identity]];
 
        //if the position array already exists, add an object to it.
        } else {
            NSMutableArray*  temp = [touch_positions objectForKey:[x identity]];
            NSMutableArray* times = [touch_times objectForKey:[x identity]];
        
            [temp addObject:[NSValue valueWithPoint:x.normalizedPosition]];
            [times addObject:[NSNumber numberWithDouble:CACurrentMediaTime()]];
        }
        
    }
    touch_positions;
}

-(CGFloat)deltaX:(NSTouch *)touch {
    NSArray* array = [touch_positions objectForKey:[touch identity]];
    CGPoint point1 = CGPointMake(0.0f, 0.0f);
    CGPoint point2 = CGPointMake(0.0f, 0.0f);
    if([array count] > 1) {
        if([array objectAtIndex:[array count] - 2]){
            point1 = [self realWorldPoint:[[array objectAtIndex:[array count]-2] pointValue] ofTouch:touch];
        }
    
        if([array objectAtIndex:[ array count] - 1] != nil) {
            point2 = [self realWorldPoint:[[array objectAtIndex:[array count]-1] pointValue] ofTouch:touch];
        }
    }
    return (point2.x-point1.x);
}

-(CGFloat)deltaY:(NSTouch *)touch {
    NSArray* array = [touch_positions objectForKey:[touch identity]];
    CGPoint point1 = CGPointMake(0.0f, 0.0f);
    CGPoint point2 = CGPointMake(0.0f, 0.0f);
    if([array count] > 1) {
        if([array objectAtIndex:[array count]-2]){
            point1 = [self realWorldPoint:[[array objectAtIndex:[array count]-2] pointValue] ofTouch:touch];
        }
        
        if([array objectAtIndex:[ array count]-1] != nil) {
            point2 = [self realWorldPoint:[[array objectAtIndex:[array count]-1] pointValue] ofTouch:touch];
        }
    }
    return (point2.y-point1.y);
}

-(CGFloat)direction:(NSTouch *)touch {
    CGFloat degrees = atan2([self deltaY:touch], [self deltaX:touch]) * (180.0 / M_PI);
    return degrees;
}

-(CGFloat)velocity:(NSTouch *)touch {
    NSArray* times = [touch_times objectForKey:[touch identity]];
    
    //Magnitude calculated by scalar dot product
    CGFloat magnitude = sqrt(pow([self deltaX:touch],2) + pow([self deltaY:touch],2));
    CGFloat time1 = 0.0;
    CGFloat time2 = 0.0;
    
    //Time delta
    if([times count] > 1) {
        time1 = [[times objectAtIndex:0]   doubleValue];
        time2 = [[times objectAtIndex:[times count]-1] doubleValue];
    }
    CGFloat timedelta = time2-time1;
    return magnitude/timedelta;

}

-(CGFloat)instantaneousVelocity:(NSTouch *)touch {
    CGFloat time1 = 0.0;
    CGFloat time2 = 0.0;
    NSArray* times = [touch_times objectForKey:[touch identity]];
    if([times count] > 1) {
        
        time1 = [[times objectAtIndex:[times count]-2]   doubleValue];
        time2 = [[times objectAtIndex:[times count]-1] doubleValue];
    }
    CGFloat timedelta = time2-time1;

    CGFloat magnitude = sqrt(pow([self deltaX:touch],2) + pow([self deltaY:touch],2));
    
    return magnitude/timedelta;
}

-(CGFloat)realWorldX:(NSTouch *)touch   {
    NSSize check = [touch deviceSize];
    return (((check.width * [touch normalizedPosition].x)/72)*25.4);
}

-(CGFloat)realWorldY:(NSTouch *)touch {
    NSSize check = [touch deviceSize];
    return (((check.height * [touch normalizedPosition].y)/72)*25.4);
}

-(CGPoint)realWorldPoint:(CGPoint)value ofTouch:(NSTouch *)touch {
    
    NSSize check = [touch deviceSize];
    CGPoint realsize;
    realsize.x = (((check.width * value.x)/72)*25.4);
    realsize.y = (((check.height * value.y)/72)*25.4);
    
    return realsize;
}

@end
