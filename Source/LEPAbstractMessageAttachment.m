//
//  LEPAbstractMessageAttachment.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 31/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPAbstractMessageAttachment.h"

#import "LEPMessageHeader.h"

@implementation LEPAbstractMessageAttachment

- (id) init
{
	self = [super init];
	
	_header = [[LEPMessageHeader alloc] init];
	
	return self;
}


- (void) setMessage:(LEPAbstractMessage *)message
{
	_message = message;
	for(LEPAbstractAttachment * attachment in _attachments) {
		[attachment setMessage:message];
	}
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super initWithCoder:decoder];
	
	_attachments = [decoder decodeObjectForKey:@"attachments"];
	_header = [decoder decodeObjectForKey:@"header"];
	
	return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
	[super encodeWithCoder:encoder];
	[encoder encodeObject:_attachments forKey:@"attachments"];
	[encoder encodeObject:_header forKey:@"header"];
}

- (id) copyWithZone:(NSZone *)zone
{
    LEPAbstractMessageAttachment * attachment;
    
    attachment = [super copyWithZone:zone];
    attachment->_header = self->_header;
    
	NSMutableArray * attachments;
	attachments = [[NSMutableArray alloc] init];
	for(LEPAbstractAttachment * subAttachment in [self attachments]) {
		[attachments addObject:[subAttachment copy]];
	}
	[attachment setAttachments:attachments];
	
	return attachment;
}
    
@end
