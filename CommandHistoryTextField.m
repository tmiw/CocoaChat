//
//  CommandHistoryTextField.m
//  CocoaChat
//
//  Created by Mooneer Salem on 10/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommandHistoryTextField.h"
#define kVK_Return 0x24
#define kVK_DownArrow 0x7D
#define kVK_UpArrow 0x7E

@implementation CommandHistoryTextField

@synthesize history;

-(id)initWithFrame:(NSRect)frameRect
{
	if ([super initWithFrame:frameRect] != nil)
	{
		history = [[CocoaChatCommandHistory alloc] init];
	}
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
	if ([super initWithCoder:aDecoder] != nil)
	{
		history = [[CocoaChatCommandHistory alloc] init];
	}
	return self;
}

-(id)init
{
	if ([super init] != nil)
	{
		history = [[CocoaChatCommandHistory alloc] init];
	}
	return self;
}

-(bool)acceptsFirstResponder
{
	return YES;
}

-(void)keyUp:(NSEvent*)event
{
	unsigned short keycode = [event keyCode];
	switch (keycode)
	{
		case kVK_UpArrow:
			[self setStringValue:[history getNextLine]];
			break;
		case kVK_DownArrow:
			[self setStringValue:[history getPreviousLine]];
			break;
		case kVK_Return:
			[history addToHistory:[self stringValue]];
			[self setStringValue:@""];
			// fall through
		default:
			[super keyUp:event];
			break;
	}
}

@end
