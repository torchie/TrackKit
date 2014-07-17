//
//  TKDetectorView+physics.m
//  TrackKit
//
//  Created by Kyle Reynolds on 7/2/14.
//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import "TKDetectorView+physics.h"
#include <mach/mach.h>

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
            [positions addObject:[NSValue valueWithPoint:x.normalizedPosition]];
            [touch_positions setObject:positions forKey:[x identity]];
//            NSLog(@"creating position array");
//            NSLog(@"Touch %@'s position list: %@", x, [touch_positions objectForKey:[x identity]]);
        //if the position array already exists, add an object to it.
        } else {
            NSMutableArray*  temp = [touch_positions objectForKey:[x identity]];
            NSMutableArray* times = [touch_times objectForKey:[x identity]];
            //NSLog(@"looking at positions array for object at %@", x);
            [temp addObject:[NSValue valueWithPoint:x.normalizedPosition]];
//            mach_absolute_time();
            //NSLog(@"touch array on %@ since addition: %@", x, [temp description]);
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

-(CGFloat)

@end
