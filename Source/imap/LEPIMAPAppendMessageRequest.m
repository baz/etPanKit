//
//  LEPIMAPAppendMessageRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 22/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPAppendMessageRequest.h"
#import "LEPIMAPSession.h"
#import "LEPIMAPSessionPrivate.h"

@interface LEPIMAPAppendMessageRequest () <LEPIMAPSessionProgressDelegate>

@property (nonatomic, assign, readwrite) size_t currentProgress;
@property (nonatomic, assign, readwrite) size_t maximumProgress;

@end

@implementation LEPIMAPAppendMessageRequest

- (id) init
{
	self = [super init];
	
    _flags = LEPIMAPMessageFlagSeen;
    
	return self;
}


- (void) mainRequest
{
	[_session _appendMessageData:_data flags:_flags toPath:_path progressDelegate:self];
}

- (void) LEPIMAPSession:(LEPIMAPSession *)session bodyProgressWithCurrent:(size_t)current maximum:(size_t)maximum
{
    [self setCurrentProgress:current];
    [self setMaximumProgress:maximum];
}

- (void) LEPIMAPSession:(LEPIMAPSession *)session itemsProgressWithCurrent:(size_t)current maximum:(size_t)maximum
{
    // do nothing
}

@end
