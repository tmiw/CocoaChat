//
//  CocoaChatOutputDelegate.h
//  CocoaChat
//
//  Created by Mooneer Salem on 10/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol CocoaChatOutputDelegate

-(void)notifySourceUpdate;
-(void)chatManager:(id)manager textReceived:(NSString*)text from:(NSString*)nick on:(NSDate*)date;

@end
