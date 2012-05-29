//
//  MWPDFPhoto.m
//  BlueNote
//
//  Created by Neal Ehardt on 5/24/12.
//  Copyright (c) 2012 Groovebug LLC. All rights reserved.
//

#import "MWPDFPhoto.h"

@implementation MWPDFPhoto

- (id)initWithPDFURL:(NSURL *)url andPreviewURL:(NSURL *)previewURL {
    if (self = [super initWithURL:previewURL]) {
        URL = url;
    }
    return self;
}

- (NSURL *)PDFURL {
    return URL;
}

@end
