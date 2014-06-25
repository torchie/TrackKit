//
//  TKDetectorView+regions.h
//  TrackKit
//
//  Created by Kyle Reynolds on 6/25/14.
//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import "TKDetectorView.h"

@interface TKDetectorView (regions)
-(void)addRegion:(NSRect)userRegion withName:(NSString*)region_name;
-(void)drawRegions;
-(void)regionIntersections;
@end
