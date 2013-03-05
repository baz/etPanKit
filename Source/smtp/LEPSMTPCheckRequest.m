//
//  LEPSMTPCheckRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 11/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPSMTPCheckRequest.h"
#import "LEPSMTPSession.h"
#import "LEPSMTPSessionPrivate.h"

@implementation LEPSMTPCheckRequest

- (id) init
{
	self = [super init];
	
	return self;
}


- (void) mainRequest
{
	_authType = [_session _checkConnection];
}

@end
