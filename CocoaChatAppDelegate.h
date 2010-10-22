//
//  CocoaChatAppDelegate.h
//  CocoaChat
//
//  Created by Mooneer Salem on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CocoaChatDataSource.h"
#import "CocoaChatViewManager.h"

@interface CocoaChatAppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSWindow *window;
	IBOutlet CocoaChatViewManager *viewManager;
	IBOutlet CocoaChatDataSource *chatDataSource;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) CocoaChatDataSource *chatDataSource;
@property (nonatomic, retain) CocoaChatViewManager *viewManager;

@end
