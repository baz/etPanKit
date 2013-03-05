//
//  LEPIMAPCopyMessageRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 22/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPCopyMessageRequest.h"
#import "LEPIMAPSession.h"
#import "LEPIMAPSessionPrivate.h"

@implementation LEPIMAPCopyMessageRequest

@synthesize uidSet = _uidSet;
@synthesize fromPath = _fromPath;
@synthesize toPath = _toPath;

- (id) init
{
	self = [super init];
	
	return self;
}


- (void) mainRequest
{
	[_session _copyMessages:_uidSet fromPath:_fromPath toPath:_toPath];
}

@end
