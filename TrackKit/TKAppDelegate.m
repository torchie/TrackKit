//
//  TKAppDelegate.m
//  TrackKit
//
//  Created by Kyle Reynolds on 5/14/14.
//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import "TKAppDelegate.h"
#import "TKMyScene.h"
#import "TKDetectorView.h"

@implementation TKAppDelegate

@synthesize window = _window;
@synthesize tkdetector = _tkdetector;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /* Pick a size for the scene */
    TKMyScene* scene = [TKMyScene sceneWithSize:CGSizeMake(1024, 768)];
    
    //Note: you don't need to construct a tkdetectorview since one already exists from instantiation via nib.
    [scene setDetector:_tkdetector];
    
    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = SKSceneScaleModeAspectFit;

    [self.skView presentScene:scene];
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
