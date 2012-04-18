//
//  KMDocumentsDrop.h
//  SimOpener
//
//  Created by Kim Hunter on 18/04/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol DocumentsDropDelegate <NSObject>
- (void)didDropFileUrl:(NSURL *)fileUrl;
@end

@interface KMDocumentsDrop : NSImageView
@property (unsafe_unretained) IBOutlet id<DocumentsDropDelegate> delegate;
@end
