//
//  MWPDFPhoto.m
//  BlueNote
//
//  Created by Neal Ehardt on 5/24/12.
//  Copyright (c) 2012 Groovebug LLC. All rights reserved.
//

#import "MWPDFPhoto.h"

@implementation MWPDFPhoto

- (id)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        URL = url;
    }
    return self;
}

- (NSURL *)PDFURL {
    return URL;
}

- (UIImage *)underlyingImage {
    return nil;
}

- (void)loadUnderlyingImageAndNotify {
    [[NSNotificationCenter defaultCenter] postNotificationName:MWPHOTO_LOADING_DID_END_NOTIFICATION object:self];
}

- (void)unloadUnderlyingImage {
    
}

@end
