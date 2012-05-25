//
//  MWPDFPage.h
//  BlueNote
//
//  Created by Neal Ehardt on 5/24/12.
//  Copyright (c) 2012 Groovebug LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MWPhotoPage.h"

@interface MWPDFPage : UIWebView <MWPhotoPage> {
	
	MWPhotoBrowser *_photoBrowser;
    id<MWPhoto> _photo;
	
    // This view references the related caption view for simplified
    // handling in photo browser
    MWCaptionView *_captionView;
    
	UIActivityIndicatorView *_spinner;
}

@end
