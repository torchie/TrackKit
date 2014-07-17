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
        //[self.view addSubview:detector];

        [self addChild:myLabel];
       
    }
    return self;
}


-(void)setDetector:(TKDetectorView*)view {
    detector = view;
    [self.view addSubview:view];
    [detector addRegion:CGRectMake(0, 0, 128, 300) withName:@"lefthand"];
    [detector addRegion:CGRectMake(128, 0, 128, 300) withName:@"righthand"];
    
}


-(void)mouseDown:(NSEvent *)theEvent {
    /* Called when a mouse click occurs */
    //NSLog(@"Click detected");
    CGPoint location = [theEvent locationInNode:self];
    
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    sprite.position = location;
    sprite.scale = 0.5;
    
    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    
    [sprite runAction:[SKAction repeatActionForever:action]];
    
    [self addChild:sprite];
}

//(C) Nial Giacomelli
- (NSPoint)convertToScreenFromLocalPoint:(NSPoint)point relativeToView:(NSView *)view {
	NSScreen *currentScreen = [NSScreen currentScreenForMouseLocation];
	if(currentScreen)
	{
		NSPoint windowPoint = [view convertPoint:point toView:nil];
		NSPoint screenPoint = [[view window] convertBaseToScreen:windowPoint];
		NSPoint flippedScreenPoint = [currentScreen flipPoint:screenPoint];
		flippedScreenPoint.y += [currentScreen frame].origin.y;
        
		return flippedScreenPoint;
	}
    
	return NSZeroPoint;
}

-(void)update:(CFTimeInterval)currentTime {
    //NOTE: ORIGINS ARE CONSIDERED BOTTOM LEFT CORNER IN OSX UI, NOT CENTER.
    CGPoint framerelative = [self convertToScreenFromLocalPoint:CGPointMake(CGRectGetMidX(detector.frame),CGRectGetMidY(detector.frame)) relativeToView:self.view]; //THIS IS IT
    
    //CGPointMake(detector.frame.origin.x, detector.frame.origin.y);
    
    //CGPointMake(CGRectGetMidX(detector.frame),CGRectGetMidY(detector.frame)); //THIS IS THE REAL NSVIEW CENTER
    //[detector convertPoint:CGPointMake( CGRectGetMidX(detector.frame),CGRectGetMidY(detector.frame)) fromView:nil];//[self convertToScreenFromLocalPoint:CGPointMake((detector.frame.size.width / 2),(detector.frame.size.height / 2)) relativeToView:self.view];
    
    //[detector convertPoint:CGPointMake( + (detector.frame.size.width / 2), detector.frame.size.height / 2) toView:nil];
    
    //[self convertToScreenFromLocalPoint:CGPointMake((detector.frame.size.width / 2),(detector.frame.size.height / 2)) relativeToView:self.view];
    
    //CGPointMake((detector.frame.origin.x + (detector.frame.size.width / 2)),(detector.frame.origin.y + (detector.frame.size.height / 2)));
    //[detector convertPoint:CGPointMake( + (detector.frame.size.width / 2)),((detector.frame.size.height / 2))) fromView:nil];//;
    
    
    //[detector convertPoint:detector.bounds.origin toView:nil];
    
    //THE PROBLEM: IT'S EXPECTING COORDINATES FROM THE FRAMERECT SIZE IT WAS INITIALIZED WITH EVEN THOUGH SMALLER ????
    CGWarpMouseCursorPosition(framerelative);
    //NSLog(@"MyScene detector report of detector center: %@", NSStringFromPoint(CGPointMake( CGRectGetMidX(detector.frame),CGRectGetMidY(detector.frame))));
    //NSLog(@"MyScene converttoscreen center: %@", NSStringFromPoint(framerelative));
    //CGWarpMouseCursorPosition(CGPointMake((CGFloat)self.size.width/2, (CGFloat)self.size.height/2));
    /* Called before each frame is rendered */
    
    //[detector getTouches];
    ////NSLog(@" touches %@", [detector getTouches]);
}

@end
