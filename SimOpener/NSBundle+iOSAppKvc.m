//
//  NSBundle+iOSAppKvc.m
//  SimOpener
//
//  Created by Kim Hunter on 18/04/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "NSBundle+iOSAppKvc.h"

@implementation NSBundle (iOSAppKvc)

- (NSString *)bundleName
{
    return [self objectForInfoDictionaryKey:(id)kCFBundleNameKey];
}

- (NSString *)modificationDate
{
    NSDictionary *attrib = [[NSFileManager defaultManager] attributesOfItemAtPath:[self bundlePath] error:NULL];    
    return [attrib objectForKey:NSFileModificationDate];
}



@end
