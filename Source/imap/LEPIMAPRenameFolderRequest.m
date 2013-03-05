//
//  LEPIMAPRenameFolderRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 20/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPRenameFolderRequest.h"
#import "LEPIMAPSession.h"
#import "LEPIMAPSessionPrivate.h"

@implementation LEPIMAPRenameFolderRequest

@synthesize oldPath = _oldPath;
@synthesize newerPath = _newerPath;

- (id) init
{
	self = [super init];
	
	return self;
}


- (void) mainRequest
{
	[_session _renameFolder:[self oldPath] withNewPath:[self newerPath]];
}

@end
