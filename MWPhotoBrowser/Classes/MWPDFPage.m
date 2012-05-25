//
//  MWPDFPage.m
//  BlueNote
//
//  Created by Neal Ehardt on 5/24/12.
//  Copyright (c) 2012 Groovebug LLC. All rights reserved.
//

#import "MWPDFPage.h"
#import "MWPhotoBrowser.h"

// Declare private methods of browser
@interface MWPhotoBrowser ()
- (UIImage *)imageForPhoto:(id<MWPhoto>)photo;
- (void)cancelControlHiding;
- (void)hideControlsAfterDelay;
@end

@implementation MWPDFPage

@synthesize photo = _photo, captionView = _captionView;

- (id)initWithPhotoBrowser:(MWPhotoBrowser *)browser {
    if ((self = [super init])) {
        _photoBrowser = browser; // no need to retain superview
        
        // WebView
        self.scalesPageToFit = YES;
		
		// Spinner
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		_spinner.hidesWhenStopped = YES;
		_spinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
		[self addSubview:_spinner];
		
		// Setup
		self.backgroundColor = [UIColor blackColor];
		self.scrollView.showsHorizontalScrollIndicator = NO;
		self.scrollView.showsVerticalScrollIndicator = NO;
		self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self prepareForReuse];
    }
    return self;
}

- (UIScrollView *)scrollView {
    return [self.subviews objectAtIndex:0];
}

- (BOOL)supportsPDF {
    return YES;
}

- (void)setPhoto:(id<MWPhoto>)photo {
    _photo = photo;
    [self displayImage];
}

- (void)prepareForReuse {
    self.photo = nil;
    [self loadHTMLString:@"<html><head><style> * {background-color: black;}</style></head></html>" baseURL:nil];
    [self bringSubviewToFront:_spinner];
    [_captionView removeFromSuperview];
    self.captionView = nil;
}

#pragma mark - Image

- (void)displayImage {
	if (_photo) {
        [self loadRequest:[NSURLRequest requestWithURL:_photo.PDFURL]];
	}
}

- (void)displayImageFailure {
	[_spinner stopAnimating];
}

- (void)setMaxMinZoomScalesForCurrentBounds {
    
}

#pragma mark - Layout

- (void)layoutSubviews {
	
	// Spinner
	if (!_spinner.hidden) _spinner.center = CGPointMake(floorf(self.bounds.size.width/2.0), 100);
	// Super
	[super layoutSubviews];
}


@end
