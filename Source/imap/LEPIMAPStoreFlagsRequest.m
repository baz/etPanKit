//
//  LEPIMAPStoreFlagsRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 20/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPStoreFlagsRequest.h"
#import "LEPIMAPSession.h"
#import "LEPIMAPSessionPrivate.h"

@implementation LEPIMAPStoreFlagsRequest

- (id) init
{
	self = [super init];
	
	return self;
}


- (void) mainRequest
{
	[_session _storeFlags:_flags kind:_kind messagesUids:_uids path:_path];
}

@end
