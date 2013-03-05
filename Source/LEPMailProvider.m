//
//  LEPMailProvider.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 1/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LEPMailProvider.h"
#import "LEPNetService.h"

#include <regex.h>

@implementation LEPMailProvider

@synthesize identifier = _identifier;

- (id) init
{
    self = [super init];
    
    _imapServices = [[NSMutableArray alloc] init];
    _smtpServices = [[NSMutableArray alloc] init];
    _popServices = [[NSMutableArray alloc] init];
    _mxSet = [[NSMutableSet alloc] init];
    
    return self;
}


- (id) initWithInfo:(NSDictionary *)info
{
    NSArray * imapInfos;
    NSArray * smtpInfos;
    NSArray * popInfos;
    NSDictionary * serverInfo;
    NSArray * mxs;
    
    self = [self init];
    
    _domainMatch = info[@"domain-match"];
    _mailboxPaths = info[@"mailboxes"];
    mxs = info[@"mx"];
    for(NSString * mx in mxs) {
        [_mxSet addObject:[mx lowercaseString]];
    }
    
    serverInfo = info[@"servers"];
    imapInfos = serverInfo[@"imap"];
    smtpInfos = serverInfo[@"smtp"];
    popInfos = serverInfo[@"pop"];
    
    for(NSDictionary * info in imapInfos) {
        LEPNetService * service;
        
        service = [[LEPNetService alloc] initWithInfo:info];
        [_imapServices addObject:service];
    }
    for(NSDictionary * info in smtpInfos) {
        LEPNetService * service;
        
        service = [[LEPNetService alloc] initWithInfo:info];
        [_smtpServices addObject:service];
    }
    for(NSDictionary * info in popInfos) {
        LEPNetService * service;
        
        service = [[LEPNetService alloc] initWithInfo:info];
        [_popServices addObject:service];
    }
    
    return self;
}

- (NSArray * /* LEPNetService */) imapServices
{
    return _imapServices;
}

- (NSArray * /* LEPNetService */) smtpServices
{
    return _smtpServices;
}

- (NSArray * /* LEPNetService */) popServices
{
    return _popServices;
}

- (BOOL) matchEmail:(NSString *)email
{
    NSArray * components;
    NSString * domain;
    const char * cDomain;
    
    components = [email componentsSeparatedByString:@"@"];
    if ([components count] < 2)
        return NO;
    
    domain = [components lastObject];
    cDomain = [domain UTF8String];
    for(__strong NSString * match in _domainMatch) {
        regex_t r;
        BOOL matched;
        
        match = [NSString stringWithFormat:@"^%@$", match];
        if (regcomp(&r, [match UTF8String], REG_EXTENDED | REG_ICASE | REG_NOSUB) != 0)
            continue;
        
        matched = NO;
        if (regexec(&r, cDomain, 0, NULL, 0) == 0) {
            matched = YES;
        }
        
        regfree(&r);
        
        if (matched)
            return YES;
    }
    
    return NO;
}

- (BOOL) matchMX:(NSString *)hostname
{
    return [_mxSet containsObject:[hostname lowercaseString]];
}

- (NSString *) sentMailFolderPath
{
    return _mailboxPaths[@"sentmail"];
}

- (NSString *) starredFolderPath
{
    return _mailboxPaths[@"starred"];
}

- (NSString *) allMailFolderPath
{
    return _mailboxPaths[@"allmail"];
}

- (NSString *) trashFolderPath
{
    return _mailboxPaths[@"trash"];
}

- (NSString *) draftsFolderPath
{
    return _mailboxPaths[@"drafts"];
}

- (NSString *) spamFolderPath
{
    return _mailboxPaths[@"spam"];
}

- (NSString *) importantFolderPath
{
    return _mailboxPaths[@"important"];
}

- (BOOL) isMainFolder:(NSString *)folderPath prefix:(NSString *)prefix
{
    for(NSString * path in [_mailboxPaths allValues]) {
        NSString * fullPath;
        
        if (prefix != nil) {
            fullPath = [prefix stringByAppendingString:path];
        }
        else {
            fullPath = path;
        }
        
        if ([fullPath isEqualToString:folderPath])
            return YES;
    }
    
    return NO;
}

@end
