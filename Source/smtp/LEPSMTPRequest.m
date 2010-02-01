//
//  LEPSMTPRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 05/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPSMTPRequest.h"

@interface LEPSMTPRequest ()

@property (nonatomic, copy) NSError * error;

@end

@implementation LEPSMTPRequest

@synthesize delegate = _delegate;
@synthesize error = _error;
@synthesize session = _session;

- (id) init
{
	self = [super init];
	
	return self;
} 

- (void) dealloc
{
	[_error release];
	[_session release];
	[super dealloc];
}

- (void) startRequest
{
	[_session queueOperation:self];
}

- (void) cancel
{
	[super cancel];
}

- (void) main
{
	if ([self isCancelled]) {
		return;
	}
	
	[self mainRequest];
	
	[self performSelectorOnMainThread:@selector(_finished) withObject:nil waitUntilDone:YES];
}

- (void) mainRequest
{
}

- (void) mainFinished
{
    if ([_session error] != nil) {
        [self setError:[_session error]];
    }
}

- (void) _finished
{
	if ([self isCancelled]) {
		return;
	}
	
	[self mainFinished];
	[[self delegate] LEPSMTPRequest_finished:self];
}

@end
