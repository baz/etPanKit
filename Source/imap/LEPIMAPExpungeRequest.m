//
//  LEPIMAPExpungeRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 26/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPExpungeRequest.h"
#import "LEPIMAPSession.h"
#import "LEPIMAPSessionPrivate.h"

@implementation LEPIMAPExpungeRequest

- (id) init
{
	self = [super init];
	
	return self;
}


- (void) mainRequest
{
	[_session _expunge:_path];
}

@end
