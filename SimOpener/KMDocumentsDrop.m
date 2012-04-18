//
//  KMDocumentsDrop.m
//  SimOpener
//
//  Created by Kim Hunter on 18/04/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "KMDocumentsDrop.h"

@implementation KMDocumentsDrop
@synthesize delegate;

- (void)awakeFromNib
{
    [self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
}

-(NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    self.alphaValue = 0.92;
    return NSDragOperationCopy;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender
{
    self.alphaValue = 1.0;
}


-(BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    return YES;
}

-(BOOL)performDragOperation:(id < NSDraggingInfo >)sender {
    
    NSPasteboard* pbrd = [sender draggingPasteboard];
    NSURL* source = [NSURL URLFromPasteboard:pbrd];
    NSLog(@"%@", source);
    [delegate didDropFileUrl:source];
    return YES;
}


@end
