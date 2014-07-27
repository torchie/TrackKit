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
            [times addObject:[NSNumber numberWithDouble:CFAbsoluteTimeGetCurrent()]];
            
            [touch_positions setObject:positions forKey:[x identity]];
            [touch_times setObject:times forKey:[x identity]];
 
//            NSLog(@"creating position array");
//            NSLog(@"Touch %@'s position list: %@", x, [touch_positions objectForKey:[x identity]]);
        //if the position array already exists, add an object to it.
        } else {
            NSMutableArray*  temp = [touch_positions objectForKey:[x identity]];
            NSMutableArray* times = [touch_times objectForKey:[x identity]];
            //NSLog(@"looking at positions array for object at %@", x);
        
            [temp addObject:[NSValue valueWithPoint:x.normalizedPosition]];
            [times addObject:[NSNumber numberWithDouble:CFAbsoluteTimeGetCurrent()]];
//            NSLog(@"cfabsolute: %.20lf",CFAbsoluteTimeGetCurrent());
//            NSLog(@"mach_absolute: %.20lf",mach_absolute_time());
//            NSLog(@"times array on %@ since addition: %@", x, [times description]);
        }
        
    }
}

-(CGFloat)deltaX:(NSTouch *)touch {
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
    //NSLog(@"deltaX, x1 %.2f, x2 %.2f",point1.x, point2.x);
    return (point2.x-point1.x);
    
    //return [touch_identities objectForKey:touch] objectAtIndex: [[touch_identities objectForKey:touch] length]
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
    //NSLog(@"deltaY y1 %.2f, y2 %.2f", point1.y, point2.y);
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
    //NSLog(@"deltax %.10lf, deltay %.10lf, times count, %ld time1: %.20f, time2, %.20f, magnitude: %.20f, time delta: %.200f, vel. %.20f", [self deltaX:touch], [self deltaY:touch], [times count], time1, time2, magnitude, timedelta, magnitude/timedelta);
    //NSLog(@"heres a realworld X : %.20f", [self realWorldX:touch]);
    //NSLog(@"heres a direction: %.20f", [self direction:touch]);
//    NSLog(@"heres an inst vel: %.20f", [self instantaneousVelocity:touch]);
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
    //NSLog(@"hellO!?!?!?");
    //deviceSize is the number of points on the device. ex. magic trackpad is ~368 points (~5.2 in) wide at 72points per inch.
    //25.4/((coordinate position * device size) * dpi)

    return realsize;
}

@end
