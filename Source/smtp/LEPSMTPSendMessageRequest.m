//
//  LEPSMTPSendMessageRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPSMTPSendMessageRequest.h"

#import "LEPAddress.h"
#import "LEPSMTPSession.h"
#import "LEPSMTPSessionPrivate.h"
#import "LEPUtils.h"

@interface LEPSMTPSendMessageRequest () <LEPSMTPSessionProgressDelegate>

@property (nonatomic, assign, readwrite) size_t currentProgress;
@property (nonatomic, assign, readwrite) size_t maximumProgress;

@end

@implementation LEPSMTPSendMessageRequest

- (id) init
{
	self = [super init];
	
	return self;
}


- (void) mainRequest
{
	LEPLog(@"smtp request");
	[_session _sendMessage:_messageData from:_from recipient:_recipient
          progressDelegate:self];
}

- (void) LEPSMTPSession:(LEPSMTPSession *)session progressWithCurrent:(size_t)current maximum:(size_t)maximum;
{
    [self setCurrentProgress:current];
    [self setMaximumProgress:maximum];
}

@end
