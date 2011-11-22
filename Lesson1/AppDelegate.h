//
//  AppDelegate.h
//  Lesson1
//
//  Created by Steve Baker on 11/21/11.
//  Copyright Beepscore LLC 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
