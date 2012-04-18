//
//  KMSimulatorTests.m
//  SimOpener
//
//  Created by Kim Hunter on 18/04/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "KMSimulatorTests.h"

@implementation KMSimulatorTests

- (void)setUp
{
    sim = [KMSimulator new];
}

- (void)tearDown
{
    sim = nil;
}

- (void)testBasePath
{
    STAssertNotNil(sim.basePath, @"basePath shouldn't be nil");
}


- (void)testAppBundles
{
    NSLog(@"%@", sim.appBundles);
    STAssertNotNil(sim.appBundles, @"appbundles shouldnt be nil");
}
- (void)testLatestVersion
{
    STAssertEqualObjects(@"5.1", sim.simVersion, @"should be equal");
}


@end
