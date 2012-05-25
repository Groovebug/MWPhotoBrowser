//
//  ZoomingScrollView.h
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 14/10/2010.
//  Copyright 2010 d3i. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPhotoProtocol.h"
#import "MWPhotoPage.h"

@class MWPhotoBrowser, MWCaptionView;

@interface MWZoomingScrollView : UIScrollView <MWPhotoPage, UIScrollViewDelegate> {
	
	MWPhotoBrowser *_photoBrowser;
    id<MWPhoto> _photo;
	
    // This view references the related caption view for simplified
    // handling in photo browser
    MWCaptionView *_captionView;
    
	UIImageView *_photoImageView;
	UIActivityIndicatorView *_spinner;
	BOOL zoomBackOut;
}

@end
