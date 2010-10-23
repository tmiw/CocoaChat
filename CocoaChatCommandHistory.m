//
//  CocoaChatCommandHistory.m
//  CocoaChat
//
//  Created by Mooneer Salem on 10/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CocoaChatCommandHistory.h"


@implementation CocoaChatCommandHistory

-(id)init
{
	lines = [[NSMutableArray alloc] init];
	return self;
}

-(void)addToHistory:(NSString*)entry
{
	[lines addObject:entry];
	currentIndex = [lines count];
}

-(NSString*)getNextLine
{
	if (currentIndex > 0)
	{
		currentIndex--;
	}
	if (currentIndex < 0) currentIndex = 0;
	return [lines objectAtIndex:currentIndex];
}

-(NSString*)getPreviousLine
{
	if (currentIndex > ([lines count] - 1))
	{
		return @"";
	}
	currentIndex++;
	return [lines objectAtIndex:currentIndex];
}

@end
