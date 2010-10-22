//
//  CocoaChatSessionManager.m
//  CocoaChat
//
//  Created by Mooneer Salem on 10/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CocoaChatSessionManager.h"


@implementation CocoaChatSessionManager

@synthesize session;
@synthesize server;
@synthesize delegate;
@synthesize channelManagers;

-(id)init
{
	session = [[IRCClientSession alloc] init];
	channels = [[NSMutableDictionary alloc] init];
	channelManagers = [[NSMutableDictionary alloc] init];
	
	return self;
}

-(id)initWithServer:(CocoaChatServer*)s
{
	if ([self init])
	{
		server = s;
		
		session.server = s.hostName;
		session.port = [NSString stringWithFormat:@"%d", s.port];
		session.nickname = s.nickname;
		session.delegate = self;
		
		// TODO
		session.username = @"cocoachat";
		session.realname = @"cocoachat";
	}
	return self;
}

-(NSString*)stringValue
{
	return [NSString stringWithFormat:@"%@", session.server];
}

-(void)connect
{
	// Create entries for each known channel, but don't autojoin just yet.
	// (this fixes the remaining rendering issues)
	for (int index = 0; index < [[server channels] count]; index++)
	{
		CocoaChatChannel *channel = [[server channels] objectAtIndex:index];
		[channels setObject:channel forKey:channel.name];
		
		CocoaChatChannelManager *manager = [[CocoaChatChannelManager alloc] init];
		[channelManagers setObject:manager forKey:channel.name];
	}
	
	[session connect];
	[session run];
}

-(void)onConnect
{	
	// Autojoin channels with autoJoin == YES
	for (int index = 0; index < [[server channels] count]; index++)
	{
		CocoaChatChannel *channel = [[server channels] objectAtIndex:index];
		if (channel.autoJoin == YES)
		{
			[session join:channel.name key:channel.key];
		}
	}
}

-(void)onJoinChannel:(IRCClientChannel*)channel
{
	channel.session = session;
	
	CocoaChatChannelManager *manager = [channelManagers objectForKey:channel.name];
	manager.channel = channel;
	manager.delegate = delegate;
	channel.delegate = manager;
	
	[manager onJoin:session.nickname];
	[delegate notifySourceUpdate];
}

- (void) onPrivmsg:(NSData *)message
			  nick:(NSString *)nick
{
	CocoaChatChannelManager *privManager = [channelManagers objectForKey:nick];
	if (privManager == nil)
	{
		privManager = [[CocoaChatChannelManager alloc] init];
		privManager.delegate = delegate;
		privManager.isPrivateMessage = YES;
		privManager.channel = [[IRCClientChannel alloc] init];
		privManager.channel.session = session;
		
		NSRange foundIndex = [nick rangeOfString:@"!"];
		privManager.channel.name = [nick substringToIndex:foundIndex.location];
		[channelManagers setObject:privManager forKey:privManager.channel.name];
		[delegate notifySourceUpdate];
	}
	
	[delegate chatManager:privManager textReceived:[[NSString alloc] initWithData:message encoding:NSUTF8StringEncoding] from:nick on:[NSDate date]];
}

- (void) onNumericEvent:(NSUInteger)event
				 origin:(NSString *)origin
				 params:(NSArray *)param
{
	NSString *fullString = [NSString stringWithFormat:@"%d ", event];
	
	for (id p in param)
	{
		fullString = [NSString stringWithFormat:@"%@%@ ", fullString, p];
	}
	[delegate chatManager:self textReceived:fullString from:origin on:[NSDate date]];
}

@end
