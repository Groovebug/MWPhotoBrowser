//
//  ZoomingScrollView.h
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 14/10/2010.
//  Copyright 2010 d3i. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPhotoProtocol.h"

@class MWPhotoBrowser, MWCaptionView;

@interface MWZoomingScrollView : UIScrollView <UIScrollViewDelegate> {
	
	MWPhotoBrowser *_photoBrowser;
    id<MWPhoto> _photo;
	
    // This view references the related caption view for simplified
    // handling in photo browser
    MWCaptionView *_captionView;
    
	UIImageView *_photoImageView;
	UIActivityIndicatorView *_spinner;
	BOOL zoomBackOut;
}

@property (nonatomic, retain) MWCaptionView *captionView;
@property (nonatomic, retain) id<MWPhoto> photo;

- (id)initWithPhotoBrowser:(MWPhotoBrowser *)browser;
- (void)displayImage;
- (void)displayImageFailure;
- (void)setMaxMinZoomScalesForCurrentBounds;
- (void)prepareForReuse;

@end
