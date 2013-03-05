//
//  LEPMailProviders.m
//  etPanKit
//
//  Created by DINH Viêt Hoà on 1/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LEPMailProvidersManager.h"
#import "LEPSingleton.h"
#import "LEPMailProvider.h"

@implementation LEPMailProvidersManager

+ (LEPMailProvidersManager *) sharedManager
{
    LEPSINGLETON(LEPMailProvidersManager)
}

- (id) init
{
    NSString * filename;
    
    self = [super init];
    
    _providers = [[NSMutableDictionary alloc] init];
    
    filename =  [[NSBundle bundleForClass:[self class]] pathForResource:@"providers" ofType:@"plist"];
    [self registerProvidersFilename:filename];
    
    return self;
}


- (void) registerProviders:(NSDictionary *)providers
{
    for(NSString * identifier in providers) {
        LEPMailProvider * provider;
        
        provider = [[LEPMailProvider alloc] initWithInfo:providers[identifier]];
        [provider setIdentifier:identifier];
        _providers[identifier] = provider;
    }
}

- (void) registerProvidersFilename:(NSString *)filename
{
    NSDictionary * providersInfos;
    
    providersInfos = [[NSDictionary alloc] initWithContentsOfFile:filename];
    [self registerProviders:providersInfos];
}

- (LEPMailProvider *) providerForEmail:(NSString *)email
{
    for(NSString * identifier in _providers) {
        LEPMailProvider * provider;
        
        provider = _providers[identifier];
        if ([provider matchEmail:email])
            return provider;
    }
    
    return nil;
}

- (LEPMailProvider *) providerForMX:(NSString *)hostname
{
    for(NSString * identifier in _providers) {
        LEPMailProvider * provider;
        
        provider = _providers[identifier];
        if ([provider matchMX:[hostname lowercaseString]])
            return provider;
    }
    
    return nil;
}

- (LEPMailProvider *) providerForIdentifier:(NSString *)identifier
{
    return _providers[identifier];
}

@end
