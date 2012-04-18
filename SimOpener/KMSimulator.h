//
//  KMSimulator.h
//  SimOpener
//
//  Created by Kim Hunter on 18/04/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KMDocumentsDrop.h"

#define SimBasePath @"~/Library/Application Support/iPhone Simulator"

@interface KMSimulator : NSObject<DocumentsDropDelegate>

@property (strong) NSString *basePath;
@property (strong) IBOutlet NSString *simVersion;
@property (readonly) IBOutlet NSArray *appBundles;
@property (assign) IBOutlet NSArrayController *arrayController;
@property (strong) id currentSelection;
- (IBAction)clickedTable:(id)sender;

- (IBAction)openSelectedDocumentsPath:(id)sender;
- (IBAction)openSelected:(id)sender;
@end
