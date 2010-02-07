//
//  LEPIMAPMessage.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 03/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPMessage.h"

#import "LEPIMAPFetchMessageRequest.h"
#import "LEPIMAPFetchMessageStructureRequest.h"
#import "LEPIMAPAccountPrivate.h"
#import "LEPIMAPFolder.h"
#import "LEPError.h"
#import "LEPMessageHeader.h"

@interface LEPIMAPMessage ()

- (void) _setupRequest:(LEPIMAPRequest *)request;

@end

@implementation LEPIMAPMessage

@synthesize flags = _flags;
@synthesize uid = _uid;
@synthesize folder = _folder;
@synthesize attachments = _attachments;

- (id) init
{
	self = [super init];
	
	return self;
} 

- (void) dealloc
{
	[_attachments release];
    [_folder release];
	[super dealloc];
}

- (void) _setUid:(uint32_t)uid
{
	_uid = uid;
}

- (void) _setFlags:(LEPIMAPMessageFlag)flags
{
	_flags = flags;
}

- (void) _setFolder:(LEPIMAPFolder *)folder
{
    [_folder release];
    _folder = [folder retain];
}

- (void) _setAttachments:(NSArray *)attachments
{
	[_attachments release];
	_attachments = [attachments retain];
}

- (void) _setupRequest:(LEPIMAPRequest *)request
{
	[[_folder account] _setupRequest: request];
}

- (LEPIMAPFetchMessageStructureRequest *) fetchMessageStructureRequest;
{
	LEPIMAPFetchMessageStructureRequest * request;
	
	request = [[LEPIMAPFetchMessageStructureRequest alloc] init];
	[request setPath:[_folder path]];
	[request setUid:[self uid]];
	[request setMessage:self];
	
    [self _setupRequest:request];
    
    return [request autorelease];
}

- (LEPIMAPFetchMessageRequest *) fetchMessageRequest;
{
	LEPIMAPFetchMessageRequest * request;
	
	request = [[LEPIMAPFetchMessageRequest alloc] init];
	[request setPath:[_folder path]];
	[request setUid:[self uid]];
	
    [self _setupRequest:request];
    
    return [request autorelease];
}

- (NSString *) description
{
	return [NSString stringWithFormat:@"<%@: 0x%p %lu %@ %@>", [self class], self, (unsigned long) [self uid], [[self header] from], [[self header] subject]];
}

@end
