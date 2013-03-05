//
//  LEPNetService.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 1/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LEPNetService.h"

@implementation LEPNetService

@synthesize hostname = _hostname;
@synthesize port = _port;
@synthesize authType = _authType;

- (id) init
{
    self = [super init];
    
    return self;
}


- (id) copyWithZone:(NSZone *)zone
{
    return [LEPNetService netServiceWithInfo:[self info]];
}

- (id) initWithInfo:(NSDictionary *)info
{
    BOOL ssl;
    BOOL starttls;
    
    self = [self init];
    
    [self setHostname:info[@"hostname"]];
    [self setPort:[info[@"port"] intValue]];
    ssl = [info[@"ssl"] boolValue];
    starttls = [info[@"starttls"] boolValue];
    if (ssl) {
        _authType = LEPAuthTypeTLS;
    }
    else if (starttls) {
        _authType = LEPAuthTypeStartTLS;
    }
    else {
        _authType = LEPAuthTypeClear;
    }
    
    return self;
}

- (NSDictionary *) info
{
    NSMutableDictionary * result;
    
    result = [NSMutableDictionary dictionary];
    if ([self hostname] != nil) {
        result[@"hostname"] = [self hostname];
    }
    if ([self port] != 0) {
        result[@"port"] = @([self port]);
    }
    switch (_authType & LEPAuthTypeConnectionMask) {
        case LEPAuthTypeTLS:
            result[@"ssl"] = @YES;
            break;
        case LEPAuthTypeStartTLS:
            result[@"starttls"] = @YES;
            break;
    }
    
    return result;
}

+ (LEPNetService *) netServiceWithInfo:(NSDictionary *)info
{
    return [[LEPNetService alloc] initWithInfo:info];
}

@end
