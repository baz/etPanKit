//
//  LEPIMAPFetchFolderMessagesRequest.h
//  etPanKit
//
//  Created by DINH Viêt Hoà on 20/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEPIMAPRequest.h"

@interface LEPIMAPFetchFolderMessagesRequest : LEPIMAPRequest {
	NSArray * _messages;
    uint32_t _fromUID;
    uint32_t _toUID;
}

@property (nonatomic) uint32_t fromUID;
@property (nonatomic) uint32_t toUID;

@property (nonatomic, readonly) NSArray * /* LEPIMAPMessage */ messages;

@end
