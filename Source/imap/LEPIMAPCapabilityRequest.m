//
//  LEPIMAPCapabilityRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 2/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPCapabilityRequest.h"

#import "LEPIMAPSessionPrivate.h"

@implementation LEPIMAPCapabilityRequest

- (id) init
{
	self = [super init];
	
	return self;
}


- (void) mainRequest
{
    _capabilities = [_session _capabilitiesForSelection:_selectionEnabled];
}

@end
