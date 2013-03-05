//
//  LEPIMAPAccount+Provider.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 1/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPAccount+Provider.h"

#import "LEPIMAPAccount+Gmail.h"
#import "LEPMailProvider.h"
#import "LEPIMAPNamespace.h"
#import "LEPIMAPFolder.h"

#define GMAIL_PROVIDER_IDENTIFIER @"gmail"

@implementation LEPIMAPAccount (Provider)

- (LEPIMAPFolder *) _providerFolderWithPath:(NSString *)path
{
    NSString * fullPath;
    
    if ([self defaultNamespace] == nil) {
        fullPath = path;
    }
    else {
        fullPath = [[[self defaultNamespace] mainPrefix] stringByAppendingString:path];
    }
    return [self folderWithPath:fullPath];
}

- (LEPIMAPFolder *) sentMailFolderForProvider:(LEPMailProvider *)provider
{
    if (_xListMapping != nil) {
        if (_xListMapping[@"sentmail"] != nil) {
            return [self _providerFolderWithPath:_xListMapping[@"sentmail"]];
        }
    }
    
    if ([[provider identifier] isEqualToString:GMAIL_PROVIDER_IDENTIFIER]) {
        return [self sentMailFolder];
    }
    
    if ([provider sentMailFolderPath] == nil)
        return nil;
    
	return [self _providerFolderWithPath:[provider sentMailFolderPath]];
}

- (LEPIMAPFolder *) starredFolderForProvider:(LEPMailProvider *)provider
{
    if (_xListMapping != nil) {
        if (_xListMapping[@"starred"] != nil) {
            return [self _providerFolderWithPath:_xListMapping[@"starred"]];
        }
    }
    
    if ([[provider identifier] isEqualToString:GMAIL_PROVIDER_IDENTIFIER]) {
        return [self starredFolder];
    }
    
    if ([provider starredFolderPath] == nil)
        return nil;
    
	return [self _providerFolderWithPath:[provider starredFolderPath]];
}

- (LEPIMAPFolder *) allMailFolderForProvider:(LEPMailProvider *)provider;
{
    if (_xListMapping != nil) {
        if (_xListMapping[@"allmail"] != nil) {
            return [self _providerFolderWithPath:_xListMapping[@"allmail"]];
        }
    }
    
    if ([[provider identifier] isEqualToString:GMAIL_PROVIDER_IDENTIFIER]) {
        return [self allMailFolder];
    }
    
    if ([provider allMailFolderPath] == nil)
        return nil;
    
	return [self _providerFolderWithPath:[provider allMailFolderPath]];
}

- (LEPIMAPFolder *) trashFolderForProvider:(LEPMailProvider *)provider;
{
    if (_xListMapping != nil) {
        if (_xListMapping[@"trash"] != nil) {
            return [self _providerFolderWithPath:_xListMapping[@"trash"]];
        }
    }
    
    if ([[provider identifier] isEqualToString:GMAIL_PROVIDER_IDENTIFIER]) {
        return [self trashFolder];
    }
    
    if ([provider trashFolderPath] == nil)
        return nil;
    
	return [self _providerFolderWithPath:[provider trashFolderPath]];
}

- (LEPIMAPFolder *) draftsFolderForProvider:(LEPMailProvider *)provider;
{
    if (_xListMapping != nil) {
        if (_xListMapping[@"drafts"] != nil) {
            return [self _providerFolderWithPath:_xListMapping[@"drafts"]];
        }
    }
    
    if ([[provider identifier] isEqualToString:GMAIL_PROVIDER_IDENTIFIER]) {
        return [self draftsFolder];
    }
    
    if ([provider draftsFolderPath] == nil)
        return nil;
    
	return [self _providerFolderWithPath:[provider draftsFolderPath]];
}

- (LEPIMAPFolder *) spamFolderForProvider:(LEPMailProvider *)provider;
{
    if (_xListMapping != nil) {
        if (_xListMapping[@"spam"] != nil) {
            return [self _providerFolderWithPath:_xListMapping[@"spam"]];
        }
    }
    
    if ([[provider identifier] isEqualToString:GMAIL_PROVIDER_IDENTIFIER]) {
        return [self spamFolder];
    }
    
    if ([provider spamFolderPath] == nil)
        return nil;
    
	return [self _providerFolderWithPath:[provider spamFolderPath]];
}

- (LEPIMAPFolder *) importantFolderForProvider:(LEPMailProvider *)provider;
{
    if (_xListMapping != nil) {
        if (_xListMapping[@"important"] != nil) {
            return [self _providerFolderWithPath:_xListMapping[@"important"]];
        }
    }
    
    if ([[provider identifier] isEqualToString:GMAIL_PROVIDER_IDENTIFIER]) {
        return [self importantFolder];
    }
    
    if ([provider importantFolderPath] == nil)
        return nil;
    
	return [self _providerFolderWithPath:[provider importantFolderPath]];
}

- (void) setXListMapping:(NSDictionary *)mapping
{
    _xListMapping = [mapping copy];
}

- (NSDictionary *) XListMapping
{
    return _xListMapping;
}

- (void) setupWithFoldersPaths:(NSArray *)paths xListHints:(NSDictionary *)mapping
{
    NSSet * pathsSet;
    unsigned int count;
    
    count = 0;
    pathsSet = [[NSSet alloc] initWithArray:paths];
    for(NSString * value in [mapping allValues]) {
        if ([pathsSet containsObject:value]) {
            count ++;
        }
    }
    
    if (count > 0) {
		[self setXListMapping:mapping];
    }
    [self setupWithFoldersPaths:paths];
}

+ (NSDictionary *) XListMappingWithFolders:(NSArray * /* LEPIMAPFolder */ )folders
{
    NSMutableDictionary * result;
    
    result = [NSMutableDictionary dictionary];
    for(LEPIMAPFolder * folder in folders) {
        if (([folder flags] & LEPIMAPMailboxFlagInbox) != 0) {
            result[@"inbox"] = [folder path];
        }
        else if (([folder flags] & LEPIMAPMailboxFlagSentMail) != 0) {
            result[@"sentmail"] = [folder path];
        }
        else if (([folder flags] & LEPIMAPMailboxFlagStarred) != 0) {
            result[@"starred"] = [folder path];
        }
        else if (([folder flags] & LEPIMAPMailboxFlagAllMail) != 0) {
            result[@"allmail"] = [folder path];
        }
        else if (([folder flags] & LEPIMAPMailboxFlagTrash) != 0) {
            result[@"trash"] = [folder path];
        }
        else if (([folder flags] & LEPIMAPMailboxFlagDrafts) != 0) {
            result[@"drafts"] = [folder path];
        }
        else if (([folder flags] & LEPIMAPMailboxFlagSpam) != 0) {
            result[@"spam"] = [folder path];
        }
        else if (([folder flags] & LEPIMAPMailboxFlagImportant) != 0) {
            result[@"important"] = [folder path];
        }
    }
    
    return result;
}

@end
