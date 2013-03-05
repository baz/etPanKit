//
//  LEPIMAPSubscribeFolderRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 20/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPSubscribeFolderRequest.h"
#import "LEPIMAPSession.h"
#import "LEPIMAPSessionPrivate.h"

@implementation LEPIMAPSubscribeFolderRequest

- (id) init
{
	self = [super init];
	
	return self;
}


- (void) mainRequest
{
	[_session _subscribeFolder:_path];
}

@end
