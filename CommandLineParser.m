//
//  CommandLineParser.m
//  CocoaChat
//
//  Created by Mooneer Salem on 10/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommandLineParser.h"


@implementation CommandLineParser

-(NSMutableArray*)parseCommandLine:(NSString*)commandLine
{
	NSRange currentRange = {0, [commandLine length]};
	NSRange proposedNewRange;
	NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@" \t\r\n\"\'"];
	NSMutableArray *result = [[NSMutableArray alloc] init];
	bool proposedInString = NO, inString = NO;
	
	while (YES)
	{
		proposedNewRange = [commandLine rangeOfCharacterFromSet:delimiters options:0 range:currentRange];
		if (proposedNewRange.location == NSNotFound) break;
		
		unichar ch = [commandLine characterAtIndex:proposedNewRange.location];
		if (ch == '"' || ch == '\'')
		{
			// String handling.
			if (proposedNewRange.location == 0) proposedInString = YES;
			else if ([commandLine characterAtIndex:(proposedNewRange.location - 1)] != '\\')
			{
				// Not being escaped--invert state.
				proposedInString = !inString;
			}
		}

		NSRange substringRange = {currentRange.location, proposedNewRange.location - currentRange.location};

		// TODO: strip '\'.
		if (inString == NO)
		{
			if (substringRange.length > 0 || 
				(substringRange.length == 0 && proposedInString == YES))
			{
				[result addObject:[commandLine substringWithRange:substringRange]];
			}
		}
		else if (inString == YES)
		{
			NSString *oldString = [result objectAtIndex:[result count]-1];
			[result removeLastObject];
			if ([oldString length] == 0)
			{
				[result addObject:
					[NSString stringWithFormat:@"%@%C", 
						[commandLine substringWithRange:substringRange], ch]];
			}
			else if (proposedInString == YES)
			{
				[result addObject:
					[NSString stringWithFormat:@"%@%@%C", 
						oldString, [commandLine substringWithRange:substringRange], ch]];
			}
			else
			{
				[result addObject:
					[NSString stringWithFormat:@"%@%@", 
						oldString, [commandLine substringWithRange:substringRange]]];
			}

		}

		currentRange.location = proposedNewRange.location + 1;
		currentRange.length = [commandLine length] - currentRange.location;
		if (inString != proposedInString) inString = proposedInString;
	}
	
	[result addObject:[commandLine substringFromIndex:currentRange.location]];
	return result;
}

@end
