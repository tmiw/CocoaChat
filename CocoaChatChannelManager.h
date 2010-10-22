//
//  CocoaChatChannelManager.h
//  CocoaChat
//
//  Created by Mooneer Salem on 10/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <IRCClient/IRCClientChannel.h>
#import <IRCClient/IRCClientSession.h>
#import "CocoaChatOutputDelegate.h"
#import "CocoaChatManager.h"

@interface CocoaChatChannelManager : CocoaChatManager {
	IRCClientChannel *channel;
	IRCClientSession *session;
	id<CocoaChatOutputDelegate> delegate;
	bool isPrivateMessage;
}

@property (nonatomic, retain) IRCClientChannel *channel;
@property (nonatomic, retain) id<CocoaChatOutputDelegate> delegate;
@property bool isPrivateMessage;

-(id)init;
-(id)initWithChannel:(IRCClientChannel*)c;
-(void)sendText:(NSString*)text;
-(NSString*)stringValue;

-(void)onJoin:(NSString *)nick;
-(void)onPrivmsg:(NSString *)message nick:(NSString *)nick;

@end
