//
//  NSTouch+physics.m
//  TrackKit
//
//  Created by Kyle Reynolds on 6/30/14.
//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import "NSTouch+physics.h"

@implementation NSTouch
@synthesize previous_positions;

-(void)phys_record {
    if(previous_positions) {
        [previous_positions addObject:[NSValue valueWithPoint:self.normalizedPosition]];
        NSLog(previous_positions);
    } else {
        previous_positions = [[NSMutableArray alloc] init];
    }
}
-(CGFloat)direction {
    return 0.5f;
}

@end
