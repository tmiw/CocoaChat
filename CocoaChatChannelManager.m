//
//  CocoaChatChannelManager.m
//  CocoaChat
//
//  Created by Mooneer Salem on 10/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CocoaChatChannelManager.h"
#import "CocoaChatDataSource.h"

@implementation CocoaChatChannelManager

@synthesize delegate;
@synthesize channel;
@synthesize isPrivateMessage;

-(id)init
{
	return self;
}

-(id)initWithChannel:(IRCClientChannel*)c
{
	if ([self init])
	{
		channel = c;
	}
	return self;
}

-(NSString*)stringValue
{
	return [NSString stringWithFormat:@"%@/%@", channel.session.server, channel.name];
}

-(void)sendText:(NSString*)text
{
	if (isPrivateMessage == NO)
	{
		[channel message:text];
		[delegate chatManager:self 
				 textReceived:text
						 from:channel.session.nickname
						   on:[NSDate date]];
	}
	else
	{
		[channel.session message:text to:channel.name];
		[delegate chatManager:self
				 textReceived:text
						 from:channel.session.nickname
						   on:[NSDate date]];
	}
}

-(void)onJoin:(NSString *)nick
{
	[delegate chatManager:self 
			 textReceived:[NSString stringWithFormat:@"%@ has joined %@", nick, channel.name]
					 from:@""
					   on:[NSDate date]];
}

-(void)onPrivmsg:(NSString *)message nick:(NSString *)nick
{
	[delegate chatManager:self 
			 textReceived:message
					 from:nick
					   on:[NSDate date]];	
}

@end
