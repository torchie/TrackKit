//
//  TKMyScene.h
//  TrackKit
//

//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class TKDetectorView;
@interface TKMyScene : SKScene {
    TKDetectorView* detector;
    NSSet* detector_touches;
}
-(void)setDetector:(TKDetectorView*)view;
@end
