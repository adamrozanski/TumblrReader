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
        [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addLayoutGuide:spacer];
        [self.contentView addSubview:self.webView];
        
        // Constraints: (must be here in case of UITableViewCell subclass, not in layoutSubviews)
        
        //spacer
        NSLayoutConstraint *spacerLeadingAnchor = [spacer.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *spacerTrailingAnchor = [spacer.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *spacerTopAnchor = [spacer.topAnchor constraintEqualToAnchor: [self.titleBox bottomAnchor]];
        self.spacerHeightAnchor = [spacer.heightAnchor constraintEqualToConstant:1];
        NSArray *spacerLabelConstraints = @[spacerLeadingAnchor, spacerTrailingAnchor, spacerTopAnchor, self.spacerHeightAnchor];
        [NSLayoutConstraint activateConstraints:spacerLabelConstraints];
        
        //webView
        NSLayoutConstraint *webViewLeadingAnchor = [self.webView.leadingAnchor constraintEqualToAnchor: [self.contentView  leadingAnchor]];
        NSLayoutConstraint *webViewTrailingAnchor = [self.webView.trailingAnchor constraintEqualToAnchor: [self.contentView  trailingAnchor]];
        NSLayoutConstraint *webViewTopAnchor = [self.webView.topAnchor constraintEqualToAnchor: [spacer bottomAnchor]];
        self.webViewHeightAnchor = [self.webView.heightAnchor constraintEqualToConstant:180];
        NSArray *webViewConstraints = @[webViewLeadingAnchor, webViewTrailingAnchor, webViewTopAnchor, self.webViewHeightAnchor];
        
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
