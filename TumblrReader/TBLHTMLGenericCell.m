//
//  TBLHTMLGenericCell.m
//  TumblrReader
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLHTMLGenericCell.h"

@implementation TBLHTMLGenericCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILayoutGuide *spacer = [[UILayoutGuide alloc] init];
        self.webView = [[WKWebView alloc] init];
        self.webView.userInteractionEnabled = NO;
        [self.webView setBackgroundColor:[UIColor whiteColor]];
        [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addLayoutGuide:spacer];
        [self.contentView addSubview:self.webView];
        
        // Constraints: (must be here in case of UITableViewCell subclass, not in layoutSubviews)
        
        //spacer
        NSLayoutConstraint *spacerLeading = [spacer.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *spacerTrailing = [spacer.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *spacerTop = [spacer.topAnchor constraintEqualToAnchor: [self.titleBox bottomAnchor]];
        NSLayoutConstraint *spacerHeight = [spacer.heightAnchor constraintEqualToConstant:10];
        NSArray *spacerLabelConstraints = @[spacerLeading, spacerTrailing, spacerTop, spacerHeight];
        [NSLayoutConstraint activateConstraints:spacerLabelConstraints];
        
        //sourceLabel
        NSLayoutConstraint *webViewLeading = [self.webView.leadingAnchor constraintEqualToAnchor: [self.contentView  leadingAnchor]];
        NSLayoutConstraint *webViewTrailing = [self.webView.trailingAnchor constraintEqualToAnchor: [self.contentView  trailingAnchor]];
        NSLayoutConstraint *webViewTop = [self.webView.topAnchor constraintEqualToAnchor: [spacer bottomAnchor]];
        NSLayoutConstraint *webViewHeight = [self.webView.heightAnchor constraintEqualToConstant:180];
        NSArray *webViewConstraints = @[webViewLeading, webViewTrailing, webViewTop, webViewHeight];
        [NSLayoutConstraint activateConstraints:webViewConstraints];
    }
    return self;
}



- (void) propagateContentFromPost:(TBLPost * _Nonnull)post andBlogMeta:(TBLBlogMeta * _Nonnull)blogMeta;
{
    [super propagateContentFromPost:post andBlogMeta:blogMeta];
    [self.webView loadHTMLString:[post toHTML] baseURL:nil];
}


@end
