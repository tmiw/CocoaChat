//
//  CocoaChatServer.m
//  CocoaChat
//
//  Created by Mooneer Salem on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CocoaChatServer.h"


@implementation CocoaChatServer

@synthesize hostName;
@synthesize port;
@synthesize nickname;
@synthesize channels;
@synthesize autoConnect;

-(id)init
{
	channels = [[NSMutableArray alloc] init];
	return self;
}

-(id)initWithHost:(NSString*)host port:(NSInteger)p nickname:(NSString*)nick
{
	if ([self init])
	{
		self.hostName = host;
		self.port = p;
		self.nickname = nick;
	}
	return self;
}

@end
