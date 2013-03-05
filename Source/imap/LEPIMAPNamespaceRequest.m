//
//  LEPIMAPNamespaceRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 2/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPNamespaceRequest.h"

#import "LEPIMAPSessionPrivate.h"
#import "LEPIMAPAccountPrivate.h"

@implementation LEPIMAPNamespaceRequest

@synthesize namespaces = _namespaces;
@synthesize account = _account;

- (id) init
{
	self = [super init];
	
	return self;
}


- (void) mainRequest
{
    _namespaces = [_session _namespace];
}

- (void) mainFinished
{
    [_account _setDefaultNamespace:_namespaces[LEPIMAPNamespacePersonal]];
}

@end
