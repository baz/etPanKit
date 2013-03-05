//
//  LEPIMAPAccount+Gmail.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 27/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEPIMAPAccount+Gmail.h"

#import "LEPIMAPFolder.h"
#import "LEPIMAPFolderPrivate.h"
#import "LEPUtils.h"

@implementation LEPIMAPAccount (Gmail)

- (LEPIMAPFolder *) sentMailFolder
{
	return [self folderWithPath:_gmailMailboxNames[@"sentmail"]];
}

- (LEPIMAPFolder *) allMailFolder
{
	return [self folderWithPath:_gmailMailboxNames[@"allmail"]];
}

- (LEPIMAPFolder *) starredFolder
{
	return [self folderWithPath:_gmailMailboxNames[@"starred"]];
}

- (LEPIMAPFolder *) trashFolder
{
	return [self folderWithPath:_gmailMailboxNames[@"trash"]];
}

- (LEPIMAPFolder *) draftsFolder
{
	return [self folderWithPath:_gmailMailboxNames[@"drafts"]];
}

- (LEPIMAPFolder *) spamFolder
{
	return [self folderWithPath:_gmailMailboxNames[@"spam"]];
}

- (LEPIMAPFolder *) importantFolder
{
	return [self folderWithPath:_gmailMailboxNames[@"important"]];
}

- (void) setGmailMailboxNames:(NSDictionary *)gmailMailboxNames
{
    _gmailMailboxNames = gmailMailboxNames;
}

- (NSDictionary *) gmailMailboxNames
{
    return _gmailMailboxNames;
}

@end
