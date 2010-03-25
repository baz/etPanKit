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
	LEPAddress * _from;
	NSArray * /* LEPAddress */ _to;
	NSArray * /* LEPAddress */ _cc;
	NSArray * /* LEPAddress */ _bcc;
	NSArray * /* LEPAddress */ _replyTo;
	NSString * _subject;
    NSDate * _date;
}

@property (nonatomic, retain) NSString * messageID;
@property (nonatomic, copy) NSArray * /* NSString */ references;
@property (nonatomic, copy) NSArray * /* NSString */ inReplyTo;

@property (nonatomic, retain) NSDate * date;

@property (nonatomic, retain) LEPAddress * from;
@property (nonatomic, copy) NSArray * /* LEPAddress */ to;
@property (nonatomic, copy) NSArray * /* LEPAddress */ cc;
@property (nonatomic, copy) NSArray * /* LEPAddress */ bcc;
@property (nonatomic, copy) NSArray * /* LEPAddress */ replyTo;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain, readonly) NSString * extractedSubject;

@end
