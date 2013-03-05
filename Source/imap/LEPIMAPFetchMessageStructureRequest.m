//
//  LEPIMAPFetchAllMessageRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 31/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPFetchMessageStructureRequest.h"

#import "LEPIMAPSession.h"
#import "LEPIMAPSessionPrivate.h"
#import "LEPUTils.h"

@implementation LEPIMAPFetchMessageStructureRequest

- (id) init
{
	self = [super init];
	
	return self;
}


- (void) mainRequest
{
	LEPLog(@"request attachments");
	_attachments = [_session _fetchMessageStructureWithUID:_uid path:_path message:_message];
}

@end
