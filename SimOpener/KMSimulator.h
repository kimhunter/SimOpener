//
//  KMSimulator.h
//  SimOpener
//
//  Created by Kim Hunter on 18/04/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SimBasePath @"~/Library/Application Support/iPhone Simulator"
@interface KMSimulator : NSObject


@property (strong) NSString *basePath;
@property (strong) NSString *simVersion;
@property (readonly) NSArray *appBundles;


@end
