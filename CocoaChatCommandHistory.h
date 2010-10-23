//
//  CocoaChatCommandHistory.h
//  CocoaChat
//
//  Created by Mooneer Salem on 10/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CocoaChatCommandHistory : NSObject {
	NSMutableArray *lines;
	NSInteger currentIndex;
}

-(id)init;
-(void)addToHistory:(NSString*)entry;
-(NSString*)getPreviousLine;
-(NSString*)getNextLine;

@end
