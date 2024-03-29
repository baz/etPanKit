//
//  LEPSMTPSendMessageRequest.h
//  etPanKit
//
//  Created by DINH Viêt Hoà on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEPSMTPRequest.h"

@class LEPAddress;

@interface LEPSMTPSendMessageRequest : LEPSMTPRequest {
	NSData * _messageData;
	LEPAddress * _from;
	NSArray * _recipient;
    size_t _currentProgress;
    size_t _maximumProgress;
}

@property (nonatomic, strong) NSData * messageData;
@property (nonatomic, strong) LEPAddress * from;
@property (nonatomic, strong) NSArray * recipient;

// progress
@property (nonatomic, assign, readonly) size_t currentProgress;
@property (nonatomic, assign, readonly) size_t maximumProgress;

@end
