//
//  MWPhotoPage.h
//  BlueNote
//
//  Created by Neal Ehardt on 5/24/12.
//  Copyright (c) 2012 Groovebug LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPhotoProtocol.h"


@class MWPhotoBrowser, MWCaptionView;


@protocol MWPhotoPage <NSObject>

@property (nonatomic, retain) MWCaptionView *captionView;
@property (nonatomic, retain) id<MWPhoto> photo;
@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) BOOL supportsPDF;

- (id)initWithPhotoBrowser:(MWPhotoBrowser *)browser;
- (void)displayImage;
- (void)displayImageFailure;
- (void)setMaxMinZoomScalesForCurrentBounds;
- (void)prepareForReuse;

@end
