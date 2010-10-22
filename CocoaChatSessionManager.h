//
//  CocoaChatSessionManager.h
//  CocoaChat
//
//  Created by Mooneer Salem on 10/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <IRCClient/IRCClientSession.h>
#import <IRCClient/IRCClientChannel.h>
#import <IRCClient/IRCClientSessionDelegate.h>
#import "CocoaChatServer.h"
#import "CocoaChatChannel.h"
#import "CocoaChatChannelManager.h"
#import "CocoaChatOutputDelegate.h"
#import "CocoaChatManager.h"

@interface CocoaChatSessionManager : CocoaChatManager {
	IRCClientSession *session;
	CocoaChatServer *server;
	id<CocoaChatOutputDelegate> delegate;
	
	NSMutableDictionary *channels;
	NSMutableDictionary *channelManagers;
}

@property (nonatomic, retain, readonly) IRCClientSession *session;
@property (nonatomic, retain) CocoaChatServer *server;
@property (nonatomic, retain) id<CocoaChatOutputDelegate> delegate;
@property (nonatomic, retain, readonly) NSMutableDictionary *channelManagers;

-(id)init;
-(id)initWithServer:(CocoaChatServer*)s;
-(void)connect;

-(void)onConnect;
-(void)onJoinChannel:(IRCClientChannel*)channel;
- (void) onPrivmsg:(NSData *)message
			  nick:(NSString *)nick;
- (void) onNumericEvent:(NSUInteger)event
				 origin:(NSString *)origin
				 params:(NSArray *)param;

-(NSString*)stringValue;

@end
