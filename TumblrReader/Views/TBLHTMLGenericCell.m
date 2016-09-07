//
//  TBLHTMLGenericCell.m
//  TumblrReader
//
//  Created by Adam Różański on 14.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLHTMLGenericCell.h"

@implementation TBLHTMLGenericCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {

        UILayoutGuide *spacer = [[UILayoutGuide alloc] init];
        self.webView = [[WKWebView alloc] init];
        self.webView.userInteractionEnabled = NO;
        [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.webView];
        [self.contentView addLayoutGuide:spacer];

        // Constraints: (must be here in case of UITableViewCell subclass, not in
        // layoutSubviews)

        // spacer
        NSLayoutConstraint *spacerLeadingConstraint = [spacer.leadingAnchor constraintEqualToAnchor:[self.contentView leadingAnchor]];
        NSLayoutConstraint *spacerTrailingConstraint = [spacer.trailingAnchor constraintEqualToAnchor:[self.contentView trailingAnchor]];
        NSLayoutConstraint *spacerTopConstraint = [spacer.topAnchor constraintEqualToAnchor:[self.titleBox bottomAnchor]];
        self.spacerHeightConstraint = [spacer.heightAnchor constraintEqualToConstant:1];
        NSArray *spacerLabelConstraints = @[ spacerLeadingConstraint,
                                             spacerTrailingConstraint,
                                             spacerTopConstraint,
                                             self.spacerHeightConstraint ];
        [NSLayoutConstraint activateConstraints:spacerLabelConstraints];

        // webView
        NSLayoutConstraint *webViewLeadingConstraint = [self.webView.leadingAnchor constraintEqualToAnchor:[self.contentView leadingAnchor]];
        NSLayoutConstraint *webViewTrailingConstraint = [self.webView.trailingAnchor constraintEqualToAnchor:[self.contentView trailingAnchor]];
        NSLayoutConstraint *webViewTopConstraint = [self.webView.topAnchor constraintEqualToAnchor:[spacer bottomAnchor]];
        self.webViewHeightConstraint = [self.webView.heightAnchor constraintEqualToConstant:180];
        NSArray *webViewConstraints = @[ webViewLeadingConstraint,
                                         webViewTrailingConstraint,
                                         webViewTopConstraint,
                                         self.webViewHeightConstraint ];
        [NSLayoutConstraint activateConstraints:webViewConstraints];

        [self attachFooterToBottomAnchor:self.webView.bottomAnchor];
    }
    return self;
}

- (void)propagateContentFromPost:(nonnull TBLPost *)post
                     andBlogMeta:(nonnull TBLBlogMeta *)blogMeta;
{
    [super propagateContentFromPost:post andBlogMeta:blogMeta];
    [self.webView loadHTMLString:[post toHTML] baseURL:nil];
}

@end
