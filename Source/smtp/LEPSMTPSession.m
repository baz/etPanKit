//
//  LEPSMTPSession.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 06/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPSMTPSession.h"

#import "LEPSMTPRequest.h"
#import "LEPUtils.h"
#import "LEPError.h"
#import "LEPAddress.h"
#import <libetpan/libetpan.h>

struct lepData {
	mailsmtp * smtp;
};

#define _smtp ((struct lepData *) _lepData)->smtp

@interface LEPSMTPSession ()

@property (nonatomic, copy) NSError * error;

- (void) _setup;
- (void) _unsetup;

- (void) _connect;
- (void) _login;
- (void) _disconnect;

@end

@implementation LEPSMTPSession

@synthesize host = _host;
@synthesize port = _port;
@synthesize login = _login;
@synthesize password = _password;
@synthesize authType = _authType;
@synthesize realm = _realm;
@synthesize error = _error;

- (id) init
{
	self = [super init];
	
	_lepData = calloc(1, sizeof(struct lepData));
	_queue = [[NSOperationQueue alloc] init];
	[_queue setMaxConcurrentOperationCount:1];
	
	return self;
}

- (void) dealloc
{
	[_host release];
	[_login release];
	[_password release];
	[_queue release];
	[_error release];
	free(_lepData);
	
	[super dealloc];
}

- (void) queueOperation:(LEPSMTPRequest *)request
{
	LEPLog(@"queue operation");

	[_queue addOperation:request];
}

- (void) _setup
{
	LEPAssert(_smtp == NULL);
	
	_smtp = mailsmtp_new(0, NULL);
}

- (void) _unsetup
{
	if (_smtp != NULL) {
		mailsmtp_free(_smtp);
		_smtp = NULL;
	}
}

- (void) _connect
{
	int r;
	
    switch (_authType) {
		case LEPAuthTypeStartTLS:
			LEPLog(@"connect %@ %u", [self host], (unsigned int) [self port]);
			r = mailsmtp_socket_connect(_smtp, [[self host] UTF8String], [self port]);
			if (r != MAILSMTP_NO_ERROR) {
				NSError * error;
				
				error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorConnection userInfo:nil];
				[self setError:error];
				[error release];
				
				return;
			}
			
			LEPLog(@"init");
			r = mailsmtp_init(_smtp);
			if (r == MAILSMTP_ERROR_STREAM) {
				NSError * error;
				
				error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorParse userInfo:nil];
				[self setError:error];
				[error release];
				return;
			}
			else if (r != MAILSMTP_NO_ERROR) {
				NSError * error;
				
				error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorConnection userInfo:nil];
				[self setError:error];
				[error release];
				return;
			}
			
			LEPLog(@"start TLS");
			r = mailsmtp_socket_starttls(_smtp);
			if (r != MAILSMTP_NO_ERROR) {
				NSError * error;
				
				error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorStartTLSNotAvailable userInfo:nil];
				[self setError:error];
				[error release];
				
				return;
			}
			LEPLog(@"done");
			
			break;
			
		case LEPAuthTypeTLS:
			r = mailsmtp_ssl_connect(_smtp, [[self host] UTF8String], [self port]);
			if (r != MAILSMTP_NO_ERROR) {
				NSError * error;
				
				error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorConnection userInfo:nil];
				[self setError:error];
				[error release];
				return;
			}
			
			LEPLog(@"init");
			r = mailsmtp_init(_smtp);
			if (r == MAILSMTP_ERROR_STREAM) {
				NSError * error;
				
				error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorParse userInfo:nil];
				[self setError:error];
				[error release];
				return;
			}
			else if (r != MAILSMTP_NO_ERROR) {
				NSError * error;
				
				error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorConnection userInfo:nil];
				[self setError:error];
				[error release];
				return;
			}
			
			break;
			
		default:
			r = mailsmtp_socket_connect(_smtp, [[self host] UTF8String], [self port]);
			if (r != MAILIMAP_NO_ERROR) {
				NSError * error;
				
				error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorConnection userInfo:nil];
				[self setError:error];
				[error release];
				return;
			}
			
			LEPLog(@"init");
			r = mailsmtp_init(_smtp);
			if (r == MAILSMTP_ERROR_STREAM) {
				NSError * error;
				
				error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorParse userInfo:nil];
				[self setError:error];
				[error release];
				return;
			}
			else if (r != MAILSMTP_NO_ERROR) {
				NSError * error;
				
				error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorConnection userInfo:nil];
				[self setError:error];
				[error release];
				return;
			}
			
			break;
    }
}

- (void) _login
{
	int r;
	
	if (([self login] == nil) || ([self password] == nil)) {
		return;
	}
	
	switch ([self authType]) {
		case LEPAuthTypeClear:
		case LEPAuthTypeStartTLS:
		case LEPAuthTypeTLS:
		default:
			r = mailesmtp_auth_sasl(_smtp, "PLAIN",
									NULL,
									NULL,
									NULL,
									[[self login] UTF8String], [[self login] UTF8String],
									[[self password] UTF8String], NULL);
			break;
			
		case LEPAuthTypeSASLCRAMMD5:
			r = mailesmtp_auth_sasl(_smtp, "CRAM-MD5",
									NULL,
									NULL,
									NULL,
									[[self login] UTF8String], [[self login] UTF8String],
									[[self password] UTF8String], NULL);
			break;
			
		case LEPAuthTypeSASLPlain:
			r = mailesmtp_auth_sasl(_smtp, "PLAIN",
									NULL,
									NULL,
									NULL,
									[[self login] UTF8String], [[self login] UTF8String],
									[[self password] UTF8String], NULL);
			break;
			
		case LEPAuthTypeSASLGSSAPI:
			// needs to be tested
			r = mailesmtp_auth_sasl(_smtp, "GSSAPI",
									[[self host] UTF8String],
									NULL,
									NULL,
									[[self login] UTF8String], [[self login] UTF8String],
									[[self password] UTF8String], NULL);
			break;
			
		case LEPAuthTypeSASLDIGESTMD5:
			r = mailesmtp_auth_sasl(_smtp, "DIGEST-MD5",
									[[self host] UTF8String],
									NULL,
									NULL,
									[[self login] UTF8String], [[self login] UTF8String],
									[[self password] UTF8String], NULL);
			if (r != MAILIMAP_NO_ERROR) {
				NSError * error;
				
				error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorAuthentication userInfo:nil];
				[self setError:error];
				[error release];
				return;
			}
			break;
			
		case LEPAuthTypeSASLLogin:
			r = mailesmtp_auth_sasl(_smtp, "LOGIN",
									NULL,
									NULL,
									NULL,
									[[self login] UTF8String], [[self login] UTF8String],
									[[self password] UTF8String], NULL);
			break;
			
		case LEPAuthTypeSASLSRP:
			r = mailesmtp_auth_sasl(_smtp, "SRP",
									NULL,
									NULL,
									NULL,
									[[self login] UTF8String], [[self login] UTF8String],
									[[self password] UTF8String], NULL);
			break;
			
		case LEPAuthTypeSASLNTLM:
			r = mailesmtp_auth_sasl(_smtp, "NTLM",
									[[self host] UTF8String],
									NULL,
									NULL,
									[[self login] UTF8String], [[self login] UTF8String],
									[[self password] UTF8String], [[self realm] UTF8String]);
			break;
			
		case LEPAuthTypeSASLKerberosV4:
			r = mailesmtp_auth_sasl(_smtp, "KERBEROS_V4",
									[[self host] UTF8String],
									NULL,
									NULL,
									[[self login] UTF8String], [[self login] UTF8String],
									[[self password] UTF8String], NULL);
			break;
	}
    if (r == MAILSMTP_ERROR_STREAM) {
        NSError * error;
        
        error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorParse userInfo:nil];
        [self setError:error];
        [error release];
        return;
    }
    else if (r != MAILSMTP_NO_ERROR) {
        NSError * error;
        
        error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorAuthentication userInfo:nil];
        [self setError:error];
        [error release];
        return;
    }
}

- (void) _disconnect
{
	mailsmtp_quit(_smtp);
}

- (void) _sendMessage:(NSData *)messageData from:(LEPAddress *)from recipient:(NSArray *)recipient
{
	clist * address_list;
	int r;
	
	LEPLog(@"setup");
	[self _setup];
	
	LEPLog(@"connect");
	[self _connect];
	if ([self error] != nil) {
		goto unsetup;
	}
	
	LEPLog(@"login");
	[self _login];
	if ([self error] != nil) {
        goto disconnect;
	}
	
	address_list = esmtp_address_list_new();
	for(LEPAddress * addr in recipient) {
		esmtp_address_list_add(address_list, (char *) [[addr mailbox] UTF8String], 0, NULL);
	}
	LEPLog(@"send");
	r = mailesmtp_send(_smtp, [[from mailbox] UTF8String], 0, NULL,
					   address_list,
					   [messageData bytes], [messageData length]);
	clist_free(address_list);
    if (r == MAILSMTP_ERROR_STREAM) {
        NSError * error;
        
        error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorParse userInfo:nil];
        [self setError:error];
        [error release];
        goto disconnect;
    }
	else if (r == MAILSMTP_ERROR_EXCEED_STORAGE_ALLOCATION) {
        NSError * error;
        
        error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorStorageLimit userInfo:nil];
        [self setError:error];
        [error release];
        goto disconnect;
	}
    else if (r != MAILSMTP_NO_ERROR) {
        NSError * error;
        
        error = [[NSError alloc] initWithDomain:LEPErrorDomain code:LEPErrorConnection userInfo:nil];
        [self setError:error];
        [error release];
        goto disconnect;
    }
	
#warning should disconnect only when there are no more requests
	
disconnect:
	LEPLog(@"disconnect");
	[self _disconnect];
unsetup:
	LEPLog(@"unsetup");
	[self _unsetup];
}

@end
