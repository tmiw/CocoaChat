//
//  CocoaChatDataSource.m
//  CocoaChat
//
//  Created by Mooneer Salem on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CocoaChatDataSource.h"

@implementation CocoaChatDataSource

@synthesize serverList;
@synthesize sessionList;

-(id)init
{
	serverList = [[NSMutableArray alloc] init];
	sessionList = [[NSMutableArray alloc] init];
	return self;
}

-(void)autoConnect:(CocoaChatViewManager*)manager
{
	for(int index = 0; index < [serverList count]; index++)
	{
		CocoaChatServer *server = [serverList objectAtIndex:index];
		if (server.autoConnect == YES)
		{
			CocoaChatSessionManager *session = [[CocoaChatSessionManager alloc] initWithServer:server];
			session.delegate = manager;
			[sessionList addObject:session];
			[session connect];
		}
	}
	
	[manager notifySourceUpdate];
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
	if (item == nil) return [sessionList count];
	else if ([item isKindOfClass:[CocoaChatSessionManager class]])
	{
		return [((CocoaChatSessionManager*)item).channelManagers count];
	}
	else if ([item isKindOfClass:[CocoaChatChannelManager class]])
	{
		CocoaChatChannelManager *mgr = (CocoaChatChannelManager*)item;
		return [mgr.channel.names count];
	}
	return 0;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
	if (item == nil) 
	{
		return [sessionList objectAtIndex:index];
	}
	else if ([item isKindOfClass:[CocoaChatSessionManager class]])
	{
		int currentIndex = 0;
		CocoaChatSessionManager *manager = ((CocoaChatSessionManager*)item);
		for (id key in manager.channelManagers)
		{
			if (currentIndex == index) return [manager.channelManagers objectForKey:key];
			currentIndex++;
		}
	}
	else if ([item isKindOfClass:[CocoaChatChannelManager class]])
	{
		CocoaChatChannelManager *mgr = (CocoaChatChannelManager*)item;
		return [mgr.channel.names objectAtIndex:index];
	}
	return nil;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
	if (item == nil) return YES;
	else if ([item isKindOfClass:[CocoaChatSessionManager class]]) 
	{
		CocoaChatSessionManager *mgr = (CocoaChatSessionManager*)item;
		if ([mgr.channelManagers count] > 0) return YES;
	}
	else if ([item isKindOfClass:[CocoaChatChannelManager class]]) 
	{
		return YES;
	}
	return NO;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
	if ([item isKindOfClass:[CocoaChatSessionManager class]])
	{
		return ((CocoaChatSessionManager*)item).server.hostName;
	}
	else if ([item isKindOfClass:[CocoaChatChannelManager class]])
	{
		return ((CocoaChatChannelManager*)item).channel.name;
	}
	return item;
}

@end
