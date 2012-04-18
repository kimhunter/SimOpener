//
//  KMSimulator.m
//  SimOpener
//
//  Created by Kim Hunter on 18/04/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "KMSimulator.h"


@interface KMSimulator ()
{
    NSMutableArray *appBundles;

}
- (NSString *)selectedSimVersion;
- (NSString *)latestVersion;
- (NSMutableArray *)appBundleSearch;
@property (strong) NSFileManager *fileMan;
@end


@implementation KMSimulator
@synthesize currentSelection;
@synthesize basePath, simVersion;
@synthesize appBundles;
@synthesize fileMan;
@synthesize arrayController;

- (id)init
{
    self = [super init];
    if (self) {
        self.fileMan = [NSFileManager defaultManager];
        self.basePath = [SimBasePath stringByExpandingTildeInPath];
        self.simVersion = [self selectedSimVersion];
        appBundles = [self appBundleSearch];
    }
    return self;
}



- (NSMutableArray *)appBundleSearch
{
    NSError *appDirError= NULL;
    NSMutableArray *apps = [NSMutableArray new];
    NSPredicate *appPred = [NSPredicate predicateWithFormat:@"self ENDSWITH '.app'"];
    NSString *rootFolder = [[basePath stringByAppendingPathComponent:simVersion] stringByAppendingPathComponent:@"Applications"];
    NSArray *appuuids = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:rootFolder error:&appDirError];

    if (appDirError) return apps;

    for (NSString *uuid in appuuids) {
        NSError *err = NULL;
        NSString *appRoot = [rootFolder stringByAppendingPathComponent:uuid];
        NSArray *folderContents = [fileMan contentsOfDirectoryAtPath:appRoot error:&err];
        NSArray *appFiles = [folderContents filteredArrayUsingPredicate:appPred];
        if (err || [appFiles count] == 0) {
            NSLog(@"%@", err);
            continue;
        }        

        NSString *appPath = [appRoot stringByAppendingPathComponent:[appFiles lastObject]];
        NSBundle *appBundle = [NSBundle bundleWithPath:appPath];
        NSLog(@"appBundle = %@", appBundle);
        [apps addObject:appBundle];
    }
    return apps;
}

- (NSString *)selectedSimVersion
{
    return [self latestVersion];
}


- (NSString *)latestVersion
{
    NSArray *versions = [fileMan contentsOfDirectoryAtPath:basePath error:NULL];
    NSArray *array = nil;
    NSString *result = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([a-z]+)"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:NULL];
    array = [versions filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return ![regex numberOfMatchesInString:evaluatedObject 
                                       options:NSMatchingCompleted 
                                         range:NSMakeRange(0, [evaluatedObject length])];
    }]];
    // sort NSNumfericSearch = WIN!
    array = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString *)obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    if ([array count] > 0)
        result = [array lastObject];
    
    return result;
}

- (IBAction)clickedTable:(id)sender {
//    NSTabView *tableView = sender;
//    NSBundle *selectedBundle = [[arrayController selectedObjects] lastObject];
//    NSString *path = [[selectedBundle bundlePath] stringByDeletingLastPathComponent];
//    NSLog(@"%@", path);
//    [[NSWorkspace sharedWorkspace] openFile:path withApplication:@"Finder"];

}
- (NSBundle *)selectedBundle
{
    return [[arrayController selectedObjects] lastObject];
}

- (IBAction)openSelectedDocumentsPath:(id)sender
{
    NSString *path = [[[self selectedBundle] bundlePath] stringByDeletingLastPathComponent];
    NSLog(@"%@", path);
    [[NSWorkspace sharedWorkspace] openFile:[path stringByAppendingPathComponent:@"Documents"] withApplication:@"Finder"];
}


- (IBAction)openSelected:(id)sender
{
    NSString *path = [[[self selectedBundle] bundlePath] stringByDeletingLastPathComponent];
    NSLog(@"%@", path);
    [[NSWorkspace sharedWorkspace] openFile:path withApplication:@"Finder"];
}

- (void)didDropFileUrl:(NSURL *)fileUrl
{
    NSURL *url = [[[[self selectedBundle] bundleURL] URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Documents" isDirectory:YES];;
    NSError *copyError = nil;
    url = [url URLByAppendingPathComponent:[fileUrl lastPathComponent]];
    NSLog(@"%@", url);
    [fileMan copyItemAtURL:fileUrl toURL:url error:&copyError];
    if (copyError) NSLog(@"%@", copyError);
}

@end
