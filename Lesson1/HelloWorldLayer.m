//
//  HelloWorldLayer.m
//  Lesson1
//
//  Created by Steve Baker on 11/21/11.
//  Copyright Beepscore LLC 2011. All rights reserved.
//

// Import the interfaces
#import "HelloWorldLayer.h"
#import "CCTouchDispatcher.h"

// declare anonymous category for "private" methods, avoid showing in .h file
// Note in Objective C no method is private, it can be called from elsewhere.
// Ref http://stackoverflow.com/questions/1052233/iphone-obj-c-anonymous-category-or-private-category
@interface HelloWorldLayer ()
- (void)nextFrame:(ccTime)dt;
- (void)registerWithTouchDispatcher;

- (void) setUpMenus;
@end


// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize cocosGuy;
@synthesize seeker1;


+ (CCScene *)scene
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

#pragma mark - Lifecycle methods
- (id)init
{
    self = [super init];
	if (self)
    {		
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
        
        [self setUpMenus];
        
        self.isTouchEnabled = YES;
	}
	return self;
}


- (void)dealloc
{
	// cocos2d will automatically release all the children (Label)
    self.cocosGuy = nil;
    self.seeker1 = nil;
	
	[super dealloc];
}


#pragma mark - Menus
- (void) setUpMenus
{
	// Create some menu items
    
    CCMenuItemImage * menuItem1 =  [CCMenuItemImage 
                                    itemFromNormalImage:@"myFirstButton.png" 
                                    selectedImage:@"myFirstButton_selected.png"
                                    block:^(id sender)
                                    {
                                        NSLog(@"The first menu was called");
                                    }];
    
	CCMenuItemImage * menuItem2 = [CCMenuItemImage 
                                   itemFromNormalImage:@"mySecondButton.png"
                                   selectedImage: @"mySecondButton_selected.png"
                                   block:^(id sender)
                                   {
                                       NSLog(@"The second menu was called");
                                   }];
    
	CCMenuItemImage * menuItem3 = [CCMenuItemImage 
                                   itemFromNormalImage:@"myThirdButton.png"
                                   selectedImage: @"myThirdButton_selected.png"
                                   block:^(id sender)
                                   {
                                       NSLog(@"The third menu was called");
                                   }];
    
	// Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
    
	// Arrange the menu items vertically
	[myMenu alignItemsVertically];
    
	// add the menu to your scene
	[self addChild:myMenu];
}

#pragma mark -
// override
- (void)registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
                                                     priority:0
                                              swallowsTouches:YES];
}


- (void)nextFrame:(ccTime)dt
{
    self.seeker1.position = ccp(self.seeker1.position.x + 100*dt, 
                                self.seeker1.position.y);
    if (self.seeker1.position.x > 480+32)
    {
        self.seeker1.position = ccp(-32, self.seeker1.position.y);
    }
}


#pragma mark - CCTargetedTouchDelegate
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}


- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [self convertTouchToNodeSpace:touch];
    [self.cocosGuy stopAllActions];
    // move cocosGuy to the touch location
    [self.cocosGuy runAction:[CCMoveTo actionWithDuration:1
                                                 position:location]];
}


@end
