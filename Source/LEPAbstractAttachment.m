//
//  LEPAbstractAttachment.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 03/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPAbstractAttachment.h"
#import "LEPUtils.h"

@implementation LEPAbstractAttachment

- (id) init
{
	self = [super init];
	
	return self;
} 


- (NSString *) description
{
	return [NSString stringWithFormat:@"<%@: 0x%p %@ %@>", [self class], self, [self mimeType], [self filename]];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	
    _filename = [decoder decodeObjectForKey:@"filename"];
    _mimeType = [decoder decodeObjectForKey:@"mimeType"];
	_charset = [decoder decodeObjectForKey:@"charset"];
	_inlineAttachment = [decoder decodeBoolForKey:@"inlineAttachment"];
	_contentID = [decoder decodeObjectForKey:@"contentID"];
	_contentLocation = [decoder decodeObjectForKey:@"contentLocation"];
    
	return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:_filename forKey:@"filename"];
	[encoder encodeObject:_mimeType forKey:@"mimeType"];
	[encoder encodeObject:_charset forKey:@"charset"];
	[encoder encodeBool:_inlineAttachment forKey:@"inlineAttachment"];
    [encoder encodeObject:_contentID forKey:@"contentID"];
    [encoder encodeObject:_contentLocation forKey:@"contentLocation"];
}

- (id) copyWithZone:(NSZone *)zone
{
    LEPAbstractAttachment * attachment;
    
    attachment = [[[self class] alloc] init];
    
	[attachment setFilename:[self filename]];
	[attachment setMimeType:[self mimeType]];
	[attachment setCharset:[self charset]];
	[attachment setContentID:[self contentID]];
	[attachment setContentLocation:[self contentLocation]];
	[attachment setInlineAttachment:[self isInlineAttachment]];
	[attachment setMessage:_message];
	
    return attachment;
}

@end
