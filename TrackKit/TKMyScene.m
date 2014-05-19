//
//  TKMyScene.m
//  TrackKit
//
//  Created by Kyle Reynolds on 5/14/14.
//  Copyright (c) 2014 Sky Print. All rights reserved.
//

#import "TKMyScene.h"
#import "TKDetectorView.h"

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


-(void)setDetector:(TKDetectorView*)view {
    detector = view;
}


-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    NSLog(@"Click detected");
    CGPoint location = [theEvent locationInNode:self];
    
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    sprite.position = location;
    sprite.scale = 0.5;
    
    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    
    [sprite runAction:[SKAction repeatActionForever:action]];
    
    [self addChild:sprite];
}

-(void)update:(CFTimeInterval)currentTime {
    //CGWarpMouseCursorPosition(CGPointMake((CGFloat)self.size.width/2, (CGFloat)self.size.height/2));
    /* Called before each frame is rendered */
    
    [detector getTouches];
    NSLog(@" touches %@", [detector getTouches]);
}

@end
