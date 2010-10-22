//
//  CocoaChatAppDelegate.m
//  CocoaChat
//
//  Created by Mooneer Salem on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CocoaChatAppDelegate.h"

@implementation CocoaChatAppDelegate

@synthesize window;
@synthesize chatDataSource;
@synthesize viewManager;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[viewManager initializeView];
	
	// Insert code here to initialize your application 
	CocoaChatServer *testServer = 
		[[CocoaChatServer alloc] initWithHost:@"localhost" 
										 port:6667 
									 nickname:@"tmiw"];
	testServer.autoConnect = YES;
	
	CocoaChatChannel *channel =
		[[CocoaChatChannel alloc] initWithChannelName:@"#cocoachat" key:@""];
	channel.autoJoin = YES;
	
	[[testServer channels] addObject:channel];
	
	/*channel =
		[[CocoaChatChannel alloc] initWithChannelName:@"#sdcolleges" key:@""];
	channel.autoJoin = YES;
	
	[[testServer channels] addObject:channel];*/
	
	[[chatDataSource serverList] addObject:testServer];
	[[viewManager chatOutlineView] reloadData];
	[[viewManager chatOutlineView] expandItem:testServer];
	
	/*NSInteger row = [[viewManager chatOutlineView] rowForItem:channel];
	[[viewManager chatOutlineView] selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
	*/
	
	[chatDataSource autoConnect:viewManager];
}

@end
