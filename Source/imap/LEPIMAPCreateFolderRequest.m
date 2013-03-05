//
//  LEPIMAPCreateFolderRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 20/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPCreateFolderRequest.h"
#import "LEPIMAPSession.h"
#import "LEPIMAPSessionPrivate.h"

@implementation LEPIMAPCreateFolderRequest

- (id) init
{
	self = [super init];
	
	return self;
}


- (void) mainRequest
{
	[_session _createFolder:_path];
}

@end
