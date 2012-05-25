//
//  MWPDFPhoto.h
//  BlueNote
//
//  Created by Neal Ehardt on 5/24/12.
//  Copyright (c) 2012 Groovebug LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPhotoProtocol.h"

@interface MWPDFPhoto : NSObject <MWPhoto> {
    NSURL *URL;
}

- (id)initWithURL:(NSURL *)url;

@end
