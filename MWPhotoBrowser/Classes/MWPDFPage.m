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
        webView = [[UIWebView alloc] init];
        webView.scalesPageToFit = YES;
        webView.delegate = self;
        [self addSubview:webView];
        self.backgroundColor = webView.backgroundColor;
		
		// Spinner
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		_spinner.hidesWhenStopped = YES;
		_spinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
		[self addSubview:_spinner];
		
		// Setup
		self.scrollView.showsHorizontalScrollIndicator = NO;
		self.scrollView.showsVerticalScrollIndicator = NO;
		self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self prepareForReuse];
        [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (UIScrollView *)scrollView {
    return [webView.subviews objectAtIndex:0];
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
    webView.hidden = YES;
    [self bringSubviewToFront:_spinner];
    [_captionView removeFromSuperview];
    self.captionView = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        UIScrollView *sv = self.scrollView;
        float minScale = (float)sv.frame.size.height / sv.contentSize.height * sv.zoomScale;
        // if you zoom out too far, the PDFs will disappear (webview bug)
        minScale = MAX(minScale, 0.34);
        
        if (zoomScaleFixCount > 0) {
            int newCount = zoomScaleFixCount-1;
            zoomScaleFixCount = 0; // prevent recursion by zeroing here
            
            sv.minimumZoomScale = minScale;
            sv.maximumZoomScale = 8;
            sv.zoomScale = minScale;
            
            UIEdgeInsets inset;
            inset.left = inset.right = (sv.frame.size.width - sv.contentSize.width)/2;
            sv.contentInset = inset;
            
            zoomScaleFixCount = newCount; // ...and unzeroing here
        }
    }
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)wv {
    zoomScaleFixCount = 4;
    [_spinner stopAnimating];
    webView.hidden = NO;
}


#pragma mark - Image

- (void)displayImage {
	if (_photo) {
        [webView loadRequest:[NSURLRequest requestWithURL:_photo.PDFURL]];
        [_spinner startAnimating];
        webView.hidden = YES;
	}
}

- (void)displayImageFailure {
	[_spinner stopAnimating];
}

- (void)setMaxMinZoomScalesForCurrentBounds {
    
}

#pragma mark - Layout

- (void)layoutSubviews {
	
    CGSize s = self.bounds.size;
    
	_spinner.center = CGPointMake(s.width/2.0, s.height/2.0);
    webView.frame = CGRectMake(0, 0, s.width, s.height);
    
	// Super
	[super layoutSubviews];
}


@end
