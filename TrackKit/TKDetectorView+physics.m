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
            point1 = [[array objectAtIndex:[array count]-2] pointValue];
        }
    
        if([array objectAtIndex:[ array count]-1] != nil) {
            point2 = [[array objectAtIndex:[array count]-1] pointValue];
        }
    }
    //NSLog(@"deltax array %@, x1 %.2f, x2 %.2f", array, point1.x, point2.x);
    return (point2.x-point1.x);
    
    //return [touch_identities objectForKey:touch] objectAtIndex: [[touch_identities objectForKey:touch] length]
}

-(CGFloat)deltaY:(NSTouch *)touch {
    NSArray* array = [touch_positions objectForKey:[touch identity]];
    CGPoint point1 = CGPointMake(0.0f, 0.0f);
    CGPoint point2 = CGPointMake(0.0f, 0.0f);
    if([array count] > 1) {
        if([array objectAtIndex:[array count]-2]){
            point1 = [[array objectAtIndex:[array count]-2] pointValue];
        }
        
        if([array objectAtIndex:[ array count]-1] != nil) {
            point2 = [[array objectAtIndex:[array count]-1] pointValue];
        }
    }
    //NSLog(@"deltax array %@, x1 %.2f, x2 %.2f", array, point1.x, point2.x);
    return (point2.y-point1.y);
}

-(CGFloat)velocity:(NSTouch *)touch {
    NSArray* positions = [touch_positions objectForKey:[touch identity]];
    NSArray* times = [touch_times objectForKey:[touch identity]];
    
    //Magnitude calculated by scalar dot product
    CGFloat magnitude = sqrt(pow([self deltaX:touch],2) + pow([self deltaY:touch],2));
    CGFloat time1 = 0.0;
    CGFloat time2 = 0.0;
    //Time delta
    NSLog([times description]);
    if([times count] > 1) {

        time1 = [[times objectAtIndex:0]   doubleValue];
        time2 = [[times objectAtIndex:[times count]-1] doubleValue];
    }
    CGFloat timedelta = time2-time1;
    NSLog(@"deltax %.10lf, deltay %.10lf, times count, %ld time1: %.20f, time2, %.20f, magnitude: %.20f, time delta: %.200f, vel. %.20f", [self deltaX:touch], [self deltaY:touch], [times count], time1, time2, magnitude, timedelta, magnitude/timedelta);
    //Note (jul 19): timedelta is an EXTREMELY precise value
    return magnitude/timedelta;
    
}



@end
