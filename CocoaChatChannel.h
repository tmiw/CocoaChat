//
//  CocoaChatChannel.h
//  CocoaChat
//
//  Created by Mooneer Salem on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CocoaChatChannel : NSObject {
	NSString *name;
	NSString *key;
	bool autoJoin;
}

@property (copy) NSString *name;
@property (copy) NSString *key;
@property bool autoJoin;

-(id)init;
-(id)initWithChannelName:(NSString*)channelName key:(NSString*)channelKey;

@end
