//
//  LEPIMAPIdleRequest.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 11/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPIdleRequest.h"
#import "LEPIMAPSession.h"
#import "LEPIMAPSessionPrivate.h"

@implementation LEPIMAPIdleRequest

- (id) init
{
	self = [super init];
	
    _lastUID = -1;
    
	return self;
}


- (void) startRequest
{
    // can cancel idle enabled
    _prepared = [_session _idlePrepare];
    
    [super startRequest];
}

- (void) mainRequest
{
    if (!_prepared)
        return;
    
    [_session _idlePath:_path lastUID:_lastUID];
}

- (void) mainFinished
{
    // can cancel idle disabled
    [_session _idleUnprepare];
}

- (void) done
{
    // cancel idle if needed
    [_session _idleDone];
}

@end
