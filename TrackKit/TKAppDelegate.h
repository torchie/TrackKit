//
//  TKAppDelegate.h
//  TrackKit
//

//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SpriteKit/SpriteKit.h>
#import "TKDetectorView.h"
@interface TKAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet TKDetectorView* tkdetector;
@property (assign) IBOutlet SKView *skView;

@end
