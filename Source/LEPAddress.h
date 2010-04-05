//
//  LEPAddress.h
//  etPanKit
//
//  Created by DINH Viêt Hoà on 30/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEPAddress : NSObject <NSCopying, NSCoding> {
	NSString * _displayName;
    NSString * _mailbox;
}

+ (LEPAddress *) addressWithDisplayName:(NSString *)displayName mailbox:(NSString *)mailbox;
+ (LEPAddress *) addressWithMailbox:(NSString *)mailbox;
+ (LEPAddress *) addressWithRFC822String:(NSString *)string;

@property (nonatomic, copy) NSString * displayName;
@property (nonatomic, copy) NSString * mailbox;

- (NSString *) nonEncodedRFC822String;
- (NSString *) RFC822String;

@end
