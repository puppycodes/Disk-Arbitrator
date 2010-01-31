/*
 *  AppError.m
 *  DiskArbitrator
 *
 *  Created by Aaron Burghardt on 1/24/10.
 *  Copyright 2010 Aaron Burghardt. All rights reserved.
 *
 */

#import "AppError.h"
#include <syslog.h>


void Log(int level, NSString *format, ...)
{
	va_list args;
	NSString *formattedError;
	
	va_start(args, format);
	
	formattedError = [[NSString alloc] initWithFormat:format arguments:args];
	
	va_end(args);
	
	const char *utfFormattedError = [formattedError UTF8String];
	
	BOOL shouldUseSyslog = [[NSUserDefaults standardUserDefaults] boolForKey:@"EnableSyslog"];
	
	if (shouldUseSyslog) 
		syslog(level, "%s\n", utfFormattedError);
	
	fprintf(stderr, "%s\n", utfFormattedError);
	
	[formattedError release];
}


void SetShouldLogToSyslog(BOOL flag)
{
	[[NSUserDefaults standardUserDefaults] setBool:flag forKey:@"EnableSyslog"];
}
