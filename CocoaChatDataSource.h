//
//  CocoaChatDataSource.h
//  CocoaChat
//
//  Created by Mooneer Salem on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CocoaChatServer.h"
#import "CocoaChatChannel.h"
#import "CocoaChatSessionManager.h"
#import "CocoaChatViewManager.h"

@interface CocoaChatDataSource : NSObject<NSOutlineViewDataSource> {
	NSMutableArray *serverList;
	NSMutableArray *sessionList;
}

@property (nonatomic, retain, readonly) NSMutableArray *serverList;
@property (nonatomic, retain, readonly) NSMutableArray *sessionList;

-(id)init;
-(void)autoConnect:(CocoaChatViewManager*)manager;

@end
