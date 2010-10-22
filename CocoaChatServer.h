//
//  CocoaChatServer.h
//  CocoaChat
//
//  Created by Mooneer Salem on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CocoaChatServer : NSObject {
	NSString *hostName;
	NSInteger port;
	NSString *nickname;
	bool autoConnect;
	NSMutableArray *channels;
}

@property (copy) NSString *hostName;
@property NSInteger port;
@property (copy) NSString *nickname;
@property (nonatomic, retain, readonly) NSMutableArray *channels;
@property bool autoConnect;

-(id)init;
-(id)initWithHost:(NSString*)host port:(NSInteger)p nickname:(NSString*)nick;

@end
