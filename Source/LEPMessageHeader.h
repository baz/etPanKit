//
//  LEPMessageHeader.h
//  etPanKit
//
//  Created by DINH Viêt Hoà on 31/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LEPAddress;

@interface LEPMessageHeader : NSObject <NSCoding> {
	NSString * _messageID;
	NSArray * /* NSString */ _references;
	NSArray * /* NSString */ _inReplyTo;
    LEPAddress * _sender;
	LEPAddress * _from;
	NSArray * /* LEPAddress */ _to;
	NSArray * /* LEPAddress */ _cc;
	NSArray * /* LEPAddress */ _bcc;
	NSArray * /* LEPAddress */ _replyTo;
	NSString * _subject;
    NSDate * _date;
	NSDate * _internalDate;
	NSString * _userAgent;
}

@property (nonatomic, strong) NSString * messageID;
@property (nonatomic, copy) NSArray * /* NSString */ references;
@property (nonatomic, copy) NSArray * /* NSString */ inReplyTo;

@property (nonatomic, strong) NSDate * date;
@property (nonatomic, strong) NSDate * internalDate;

@property (nonatomic, strong) LEPAddress * sender;
@property (nonatomic, strong) LEPAddress * from;
@property (nonatomic, copy) NSArray * /* LEPAddress */ to;
@property (nonatomic, copy) NSArray * /* LEPAddress */ cc;
@property (nonatomic, copy) NSArray * /* LEPAddress */ bcc;
@property (nonatomic, copy) NSArray * /* LEPAddress */ replyTo;
@property (nonatomic, strong) NSString * subject;
@property (nonatomic, strong, readonly) NSString * extractedSubject;
@property (nonatomic, strong, readonly) NSString * partialExtractedSubject;

// X-Mailer, currently only used when generating message
@property (nonatomic, copy) NSString * userAgent;

@end
