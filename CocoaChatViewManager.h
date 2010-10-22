//
//  CocoaChatViewManager.h
//  CocoaChat
//
//  Created by Mooneer Salem on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import <BWToolkitFramework/BWToolkitFramework.h>
#import "CocoaChatOutputDelegate.h"
#import "CocoaChatSessionManager.h"
#import "CocoaChatChannelManager.h"

@interface CocoaChatViewManager : NSObject<NSOutlineViewDelegate, NSTextFieldDelegate, CocoaChatOutputDelegate> {
	IBOutlet WebView *chatContentsView;
	IBOutlet NSOutlineView *chatOutlineView;
	IBOutlet NSTextField *chatTextField;
	IBOutlet NSWindow *chatWindow;
	IBOutlet NSMenu *channelContextMenu;
	IBOutlet BWAnchoredPopUpButtonCell *selectedItemMenu;
	
	IBOutlet NSWindow *channelInspectorWindow;
	
	NSMutableDictionary *channelLayouts;
	DOMElement *styleElement;
}

@property (nonatomic, retain) WebView *chatContentsView;
@property (nonatomic, retain) NSOutlineView *chatOutlineView;
@property (nonatomic, retain) NSTextField *chatTextField;
@property (nonatomic, retain) NSWindow *chatWindow;
@property (nonatomic, retain) BWAnchoredPopUpButtonCell *selectedItemMenu;
@property (nonatomic, retain) NSMenu *channelContextMenu;
@property (nonatomic, retain) BWAnchoredPopUpButtonCell *popupCell;
@property (nonatomic, retain) NSWindow *channelInspectorWindow;

-(void)initializeView;
-(id)getCurrentSelectedManager;

- (void)controlTextDidEndEditing:(NSNotification *)nd;
- (void)outlineViewSelectionDidChange:(NSNotification *)notification;

-(void)leaveChannel;
-(void)openChannelInspector;

-(void)notifySourceUpdate;
-(void)chatManager:(id)manager textReceived:(NSString*)text from:(NSString*)nick on:(NSDate*)date;

@end
