//
//  HelloWorldLayer.m
//  Lesson1
//
//  Created by Steve Baker on 11/21/11.
//  Copyright Beepscore LLC 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// declare anonymous category for "private" methods, avoid showing in .h file
// Note in Objective C no method is private, it can be called from elsewhere.
// Ref http://stackoverflow.com/questions/1052233/iphone-obj-c-anonymous-category-or-private-category
@interface HelloWorldLayer ()
- (void) nextFrame:(ccTime)dt;
@end


// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize seeker1;
@synthesize cocosGuy;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        // create and initalize our seeker sprite, and add it to this layer
        self.seeker1 = [CCSprite spriteWithFile:@"seeker.png"];
        self.seeker1.position = ccp(50, 100);
        [self addChild:self.seeker1];
        
        // do the same for our cocos2d guy, reusing the app icon as its image
        self.cocosGuy = [CCSprite spriteWithFile:@"Icon.png"];
        self.cocosGuy.position = ccp(200, 300);
        [self addChild:self.cocosGuy];
        
        // schedule a repeating callback on every frame
        [self schedule:@selector(nextFrame:)];
	}
	return self;
}


- (void) nextFrame:(ccTime)dt
{
    self.seeker1.position = ccp(self.seeker1.position.x + 100*dt, 
                                self.seeker1.position.y);
    if (self.seeker1.position.x > 480+32) {
        self.seeker1.position = ccp(-32, self.seeker1.position.y);
    }
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    self.cocosGuy = nil;
    self.seeker1 = nil;
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
