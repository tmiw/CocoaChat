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
	NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@" \t\r\n\"\\"];
	NSMutableArray *result = [[NSMutableArray alloc] init];
	bool proposedInString = NO, inString = NO, escaping = NO;
	
	while (YES)
	{
		proposedNewRange = [commandLine rangeOfCharacterFromSet:delimiters options:0 range:currentRange];
		if (proposedNewRange.location == NSNotFound) break;
		
		unichar ch = [commandLine characterAtIndex:proposedNewRange.location];
		escaping = NO;
		if (ch == '"')
		{
			// String handling.
			if (proposedNewRange.location == 0) proposedInString = YES;
			else if ([commandLine characterAtIndex:(proposedNewRange.location - 1)] != '\\')
			{
				// Not being escaped--invert state.
				proposedInString = !inString;
			}
		}

		if (ch == '\\')
		{
			escaping = YES;
			ch = [commandLine characterAtIndex:proposedNewRange.location + 1];
		}
		
		NSRange substringRange = {currentRange.location, proposedNewRange.location - currentRange.location};
		
		NSString *stringToAdd = nil;
		if (inString == NO)
		{
			if (substringRange.length > 0 || 
				(substringRange.length == 0 && proposedInString == YES))
			{
				stringToAdd = [commandLine substringWithRange:substringRange];
			}
			else if (escaping == YES)
			{
				stringToAdd = [NSString stringWithFormat:@"%C", ch];
			}
		}
		else if (inString == YES)
		{
			NSString *oldString = [result objectAtIndex:[result count]-1];
			[result removeLastObject];
			if ([oldString length] == 0)
			{
				stringToAdd = 
					[NSString stringWithFormat:@"%@%C", 
						[commandLine substringWithRange:substringRange], ch];
			}
			else if (proposedInString == YES)
			{
				stringToAdd = 
					[NSString stringWithFormat:@"%@%@%C", 
						oldString, [commandLine substringWithRange:substringRange], ch];
			}
			else
			{
				stringToAdd = 
					[NSString stringWithFormat:@"%@%@", 
						oldString, [commandLine substringWithRange:substringRange]];
			}

		}

		if (stringToAdd != nil)
		{
			[result addObject:stringToAdd];
		}
		
		// Move forward past character being escaped, if in escape mode,
		// to prevent tokenizer from grabbing it again (e.g. \")
		if (escaping == YES)
		{
			proposedNewRange.location++;
		}
		
		currentRange.location = proposedNewRange.location + 1;
		currentRange.length = [commandLine length] - currentRange.location;
		if (inString != proposedInString) inString = proposedInString;
	}
	
	NSString *endString = [commandLine substringFromIndex:currentRange.location];
	if ([endString length] > 0)
	{
		[result addObject:endString];
	}
	
	return result;
}

@end
