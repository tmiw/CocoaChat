//
//  CommandHistoryTextField.h
//  CocoaChat
//
//  Created by Mooneer Salem on 10/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CocoaChatCommandHistory.h"

@interface CommandHistoryTextField : NSTextField {
	CocoaChatCommandHistory *history;
}

@property (nonatomic, retain, readonly) CocoaChatCommandHistory *history;

-(id)init;
-(bool)acceptsFirstResponder;
-(void)keyUp:(NSEvent*)event;

@end
