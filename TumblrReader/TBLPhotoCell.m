//
//  TBPhotoCell.m
//  TumblrReader
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPhotoCell.h"

@implementation TBLPhotoCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *_Nullable)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILayoutGuide *spacer = [[UILayoutGuide alloc] init];
        self.photoView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.photoView.contentMode = UIViewContentModeScaleAspectFill;
        self.photoView.clipsToBounds = YES;
        [self.photoView setBackgroundColor:[UIColor whiteColor]];
        [self.photoView setTranslatesAutoresizingMaskIntoConstraints:NO];

        self.captionView = [[WKWebView alloc] init];
        self.captionView.userInteractionEnabled = NO;
        [self.captionView setBackgroundColor:[UIColor whiteColor]];
        [self.captionView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.captionView];

        [self.contentView addLayoutGuide:spacer];
        [self.contentView addSubview:self.photoView];

        // Constraints: (must be here in case of UITableViewCell subclass, not in layoutSubviews)

        //spacer
        NSLayoutConstraint *spacerLeading = [spacer.leadingAnchor constraintEqualToAnchor:[self.contentView leadingAnchor]];
        NSLayoutConstraint *spacerTrailing = [spacer.trailingAnchor constraintEqualToAnchor:[self.contentView trailingAnchor]];
        NSLayoutConstraint *spacerTop = [spacer.topAnchor constraintEqualToAnchor:[self.titleBox bottomAnchor]];
        NSLayoutConstraint *spacerHeight = [spacer.heightAnchor constraintEqualToConstant:1];
        NSArray *spacer1LabelConstraints = @[spacerLeading, spacerTrailing, spacerTop, spacerHeight];
        [NSLayoutConstraint activateConstraints:spacer1LabelConstraints];

        //photoView
        NSLayoutConstraint *photoViewLeading = [self.photoView.leadingAnchor constraintEqualToAnchor:[self.contentView leadingAnchor]];
        NSLayoutConstraint *photoViewTrailing = [self.photoView.trailingAnchor constraintEqualToAnchor:[self.contentView trailingAnchor]];
        NSLayoutConstraint *photoViewTop = [self.photoView.topAnchor constraintEqualToAnchor:[spacer bottomAnchor]];
        NSLayoutConstraint *photoViewHeight = [self.photoView.heightAnchor constraintEqualToConstant:180];
        NSArray *photoViewConstraints = @[photoViewLeading, photoViewTrailing, photoViewTop, photoViewHeight];
        [NSLayoutConstraint activateConstraints:photoViewConstraints];

        //captionView
        NSLayoutConstraint *captionViewLeading = [self.captionView.leadingAnchor constraintEqualToAnchor:[self.contentView leadingAnchor]];
        NSLayoutConstraint *captionViewTrailing = [self.captionView.trailingAnchor constraintEqualToAnchor:[self.contentView trailingAnchor]];
        NSLayoutConstraint *captionViewTop = [self.captionView.topAnchor constraintEqualToAnchor:[self.photoView bottomAnchor]];
        NSLayoutConstraint *captionViewHeight = [self.captionView.heightAnchor constraintEqualToConstant:18];
        NSArray *captionViewConstraints = @[captionViewLeading, captionViewTrailing, captionViewTop, captionViewHeight];
        [NSLayoutConstraint activateConstraints:captionViewConstraints];

        [self attachFooterToBottomAnchor:self.captionView.bottomAnchor];
    }
    return self;
}

- (void)propagateContentFromPost:(TBLPost *_Nonnull)post andBlogMeta:(TBLBlogMeta *_Nonnull)blogMeta {
    [super propagateContentFromPost:post andBlogMeta:blogMeta];
    [self.captionView loadHTMLString:[(TBLPhotoPost *)post captionToHTML] baseURL:nil];
}

@end
