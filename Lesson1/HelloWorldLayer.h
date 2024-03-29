//
//  HelloWorldLayer.h
//  Lesson1
//
//  Created by Steve Baker on 11/21/11.
//  Copyright Beepscore LLC 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <CCTargetedTouchDelegate>
{
}

@property (nonatomic, retain) CCSprite *cocosGuy;
@property (nonatomic, retain) CCSprite *seeker1;

// returns a CCScene that contains the HelloWorldLayer as the only child
+ (CCScene *)scene;

@end
