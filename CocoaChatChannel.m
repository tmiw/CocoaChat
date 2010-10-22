//
//  CocoaChatChannel.m
//  CocoaChat
//
//  Created by Mooneer Salem on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CocoaChatChannel.h"


@implementation CocoaChatChannel

@synthesize name;
@synthesize key;
@synthesize autoJoin;

-(id)init
{
	return self;
}

-(id)initWithChannelName:(NSString*)channelName key:(NSString*)channelKey
{
	self.name = channelName;
	self.key = channelKey;
	return self;
}

@end
