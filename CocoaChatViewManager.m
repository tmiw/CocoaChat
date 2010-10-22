//
//  CocoaChatViewManager.m
//  CocoaChat
//
//  Created by Mooneer Salem on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CocoaChatViewManager.h"
#import "CocoaChatDataSource.h"

@implementation CocoaChatViewManager

@synthesize chatContentsView;
@synthesize chatOutlineView;
@synthesize chatTextField;
@synthesize chatWindow;
@synthesize selectedItemMenu;
@synthesize channelContextMenu;
@synthesize popupCell;

@synthesize channelInspectorWindow;

-(void)initializeView
{	
	// Initialize basic CSS style (TODO: make themeable later)
	NSString *css = 
		@"body { background-color: black; color: white; font-family: Andale Mono; font-size: 12px } \
		  .date { } \
	      .nick { font-weight: bold; } \
		  .text { }";
	DOMDocument *doc = [[chatContentsView mainFrame] DOMDocument];
	DOMElement *docElement = [doc documentElement];

	if (styleElement == nil)
	{
		styleElement = [doc createElement:@"style"];
		[styleElement setAttribute:@"type" value:@"text/css"];
		DOMText *styleContents = [doc createTextNode:css];
		[styleElement appendChild:styleContents];
	}
	
	[docElement appendChild:styleElement];
	[docElement appendChild:[doc createElement:@"body"]];
	
	channelLayouts = [[NSMutableDictionary alloc] init];
}

-(id)getCurrentSelectedManager
{
	NSInteger row = [chatOutlineView selectedRow];
	
	if (row >= 0)
	{
		id cell = [chatOutlineView itemAtRow:row];
		if ([cell isKindOfClass:[CocoaChatSessionManager class]] ||
			[cell isKindOfClass:[CocoaChatChannelManager class]])
		{
				return cell;
		}
	}
	
	return nil;
}

-(void)leaveChannel
{
	NSLog(@"Left channel");
}

-(void)openChannelInspector
{
	[channelInspectorWindow makeKeyAndOrderFront:nil];
}

- (void)controlTextDidEndEditing:(NSNotification *)nd
{
	NSTextField *textfield = [nd object];
    NSDictionary *dict  = [nd userInfo];
    NSNumber  *reason = [dict objectForKey: @"NSTextMovement"];
    int code = [reason intValue];
	
    if (code == NSReturnTextMovement)
	{
		CocoaChatChannelManager *channelManager = [self getCurrentSelectedManager];
		if (channelManager != nil)
		{
			[channelManager sendText:[textfield stringValue]];
			[textfield setStringValue:@""];
		}
	}
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
	NSOutlineView *view = [notification object];
	NSInteger row = [view selectedRow];
	id cell = [view itemAtRow:row];
	
	if ([cell isKindOfClass:[CocoaChatChannelManager class]] ||
		[cell isKindOfClass:[CocoaChatSessionManager class]])
	{
		// Change channel
		CocoaChatManager *channelManager = [self getCurrentSelectedManager];
		if (channelManager != nil)
		{
			DOMDocument *doc = [[chatContentsView mainFrame] DOMDocument];
			DOMElement *docElement = [doc documentElement];
			DOMElement *newDocBodyElement = [channelLayouts objectForKey:[channelManager stringValue]];
			
			if (newDocBodyElement == nil)
			{
				newDocBodyElement = [doc createElement:@"body"];
				[channelLayouts setObject:newDocBodyElement forKey:[channelManager stringValue]];
			}
			
			[docElement removeChild:[docElement lastElementChild]];
			[docElement appendChild:newDocBodyElement];
			[chatContentsView setNeedsDisplay:YES];
			
			[selectedItemMenu setMenu:channelContextMenu];
			[chatWindow makeFirstResponder:chatTextField];
		}
	}
}

-(void)notifySourceUpdate
{
	[chatOutlineView reloadData];
}

-(void)chatManager:(id)manager textReceived:(NSString*)text from:(NSString*)nick on:(NSDate*)date;
{
	DOMDocument *doc = [[chatContentsView mainFrame] DOMDocument];
	DOMElement *docElement = [doc documentElement];
	DOMElement *docBodyElement = [docElement lastElementChild];
	
	if ((docBodyElement = [channelLayouts objectForKey:[manager stringValue]]) == nil)
	{
		docBodyElement = [doc createElement:@"body"];
		[channelLayouts setObject:docBodyElement forKey:[manager stringValue]];
	}
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeStyle:NSDateFormatterMediumStyle];
	[formatter setDateStyle:NSDateFormatterNoStyle];
	
	NSString *newNick = nick;
	if ([nick length] > 0)
	{
		NSRange range = [nick rangeOfString:@"!"];
		if (range.location != NSNotFound)
		{
			newNick = [NSString stringWithFormat:@"<%@>", [nick substringToIndex:range.location]];
		}
		else
		{
			newNick = [NSString stringWithFormat:@"<%@>", nick];
		}

	}
	
	DOMElement *dateElement = [doc createElement:@"span"];
	DOMElement *nickElement = [doc createElement:@"span"];
	DOMElement *textElement = [doc createElement:@"span"];
	[dateElement setAttribute:@"class" value:@"date"];
	[nickElement setAttribute:@"class" value:@"nick"];
	[textElement setAttribute:@"class" value:@"text"];
	
	[dateElement appendChild:[doc createTextNode:[formatter stringFromDate:date]]];
	[nickElement appendChild:[doc createTextNode:newNick]];
	[textElement appendChild:[doc createTextNode:text]];
	
	DOMElement *newElement = [doc createElement:@"div"];
	
	// Save current position in view.
	NSScrollView *scrollView = [[[[chatContentsView mainFrame] frameView] documentView] enclosingScrollView];
	NSRect scrollViewBounds = [[scrollView contentView] bounds];
	CGPoint savedScrollPosition=scrollViewBounds.origin; // keep track of position to restore
	
	bool scrollToBottom = NO;
	CGFloat oldHeight = [[scrollView contentView] documentRect].size.height;
	if (savedScrollPosition.y + scrollViewBounds.size.height == oldHeight)
	{
		scrollToBottom = YES;
	}
	
	[newElement appendChild:dateElement];
	[newElement appendChild:[doc createTextNode:@" "]];
	[newElement appendChild:nickElement];
	[newElement appendChild:[doc createTextNode:@" "]];
	[newElement appendChild:textElement];
	[docBodyElement appendChild:newElement];
	
	// Now scroll to the original position, or bottom if currently at bottom.
	[chatContentsView display];
	if (scrollToBottom == YES)
	{
		//CGFloat newHeight = [[scrollView contentView] documentRect].size.height;
		savedScrollPosition.y += oldHeight;
	}
	[[scrollView documentView] scrollPoint:savedScrollPosition];
	[chatContentsView display];
}

@end
