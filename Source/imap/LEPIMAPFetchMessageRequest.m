//
//  LEPIMAPFetchMessageRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 31/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPFetchMessageRequest.h"

#import "LEPIMAPSession.h"
#import "LEPIMAPSessionPrivate.h"

@interface LEPIMAPFetchMessageRequest () <LEPIMAPSessionProgressDelegate>

@property (nonatomic, assign, readwrite) size_t currentProgress;
@property (nonatomic, assign, readwrite) size_t maximumProgress;

@end

@implementation LEPIMAPFetchMessageRequest

- (id) init
{
	self = [super init];
	
	return self;
}


- (void) mainRequest
{
	_messageData = [_session _fetchMessageWithUID:_uid path:_path
                     progressDelegate:self];
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
