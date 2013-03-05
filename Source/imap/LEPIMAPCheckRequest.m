//
//  LEPIMAPCheckRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 3/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPCheckRequest.h"

#import "LEPIMAPSessionPrivate.h"

@implementation LEPIMAPCheckRequest

- (void) mainRequest
{
	_authType = [_session _checkConnection];
}

@end
