//
//  TKMyScene.m
//  TrackKit
//
//  Created by Kyle Reynolds on 5/14/14.
//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import "TKMyScene.h"
#import "TKDetectorView.h"
#import "NSScreen+PointConversion.h"
#import "TKDetectorView+regions.h"
@implementation TKMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));

        [self addChild:myLabel];
    }
    return self;
}

//Override to add custom detector regions.
-(void)setDetector:(TKDetectorView*)view {
    detector = view;
    [self.view addSubview:view];
    [detector addRegion:CGRectMake(0, 0, detector.frame.size.width/3, detector.frame.size.height) withName:@"lefthand"];
    [detector addRegion:CGRectMake(detector.frame.size.width*(2/3), 0, 128, 300) withName:@"righthand"];
    
}

//Mouse Down places a spaceship.
-(void)mouseDown:(NSEvent *)theEvent {
    CGPoint location = [theEvent locationInNode:self];
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    sprite.position = location;
    sprite.scale = 0.5;
    
    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    
    [sprite runAction:[SKAction repeatActionForever:action]];
    
    [self addChild:sprite];
}

-(void)update:(CFTimeInterval)currentTime {
    //Call setNeedsDisplay from the detector's superview to prevent touchesMovedWithEvent calls from the built-in trackpad from pausing the scene rendering.
    [detector setNeedsDisplay:YES];
}

@end
