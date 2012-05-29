//
//  MWPDFPhoto.h
//  BlueNote
//
//  Created by Neal Ehardt on 5/24/12.
//  Copyright (c) 2012 Groovebug LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPhoto.h"

@interface MWPDFPhoto : MWPhoto <MWPhoto> {
    NSURL *URL;
}

- (id)initWithPDFURL:(NSURL *)url andPreviewURL:(NSURL *)previewURL;

@end
