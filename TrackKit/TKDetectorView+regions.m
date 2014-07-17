//
//  TKDetectorView+regions.m
//  TrackKit
//
//  Created by Kyle Reynolds on 6/25/14.
//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import "TKDetectorView+regions.h"

@implementation TKDetectorView (regions)
-(void)addRegion:(NSRect)userRegion withName:(NSString *)region_name {
    [trackpad_regions setValue:[NSValue valueWithRect:userRegion]  forKey:region_name];
    NSLog(@"Regions added: %@", NSStringFromRect([[trackpad_regions valueForKey:region_name] rectValue]));
    NSLog(@"all regions: %@", trackpad_regions);
}
-(void)drawRegions {

    for(NSValue* x in [trackpad_regions allValues]) {
//        NSLog(@"printing regions: %@", NSStringFromRect([x rectValue]));
        
        NSBezierPath* square = [NSBezierPath bezierPath];
        [square appendBezierPathWithRect:[x rectValue]];
        [[NSColor whiteColor] setFill];
        [[NSColor whiteColor] setStroke];
        [square stroke];
    }
}

-(void)regionIntersections {
    for(NSValue* y in [trackpad_regions allValues]) {
//        if(CGRectIntersectsRect(<#CGRect rect1#>, <#CGRect rect2#>))
        for(NSTouch* x in [touch_identities allValues]) {
            //NSLog(@"yoyoyoyoyoyo we're operating with %@ ", x);
            CGRect testagainst = CGRectMake(x.normalizedPosition.x*self.bounds.size.width, x.normalizedPosition.y*self.bounds.size.height, point_size, point_size);
            
            if(CGRectIntersectsRect(testagainst, [y rectValue])) {
                NSBezierPath* square = [NSBezierPath bezierPath];
                [square appendBezierPathWithRect:[y rectValue]];
                [[NSColor redColor] set];
                [square fill];
                [square stroke];
            }
        }
    }
}
@end
