//
//  TBPhotoCell.m
//  TUMBL
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPhotoCell.h"

@implementation TBLPhotoCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILayoutGuide *spacer1 = [[UILayoutGuide alloc] init];
        self.photoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder"]];
        self.photoView.contentMode = UIViewContentModeScaleAspectFill;
        self.photoView.clipsToBounds = YES;
        [self.photoView setBackgroundColor:[UIColor yellowColor]];
        [self.photoView setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.captionView = [[WKWebView alloc] init];
        self.captionView.userInteractionEnabled = NO;
        [self.captionView setBackgroundColor:[UIColor whiteColor]];
        [self.captionView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addLayoutGuide:spacer1];
        [self.contentView addSubview:self.photoView];
        [self.contentView addSubview:self.captionView];
        
        // Constraints: (must be here in case of UITableViewCell subclass, not in layoutSubviews)
        
        //spacer1
        NSLayoutConstraint *spacer1Leading = [spacer1.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *spacer1Trailing = [spacer1.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *spacer1Top = [spacer1.topAnchor constraintEqualToAnchor: [self.titleBox bottomAnchor]];
        NSLayoutConstraint *spacer1Height = [spacer1.heightAnchor constraintEqualToConstant:1];
        NSArray *spacer1LabelConstraints = @[spacer1Leading, spacer1Trailing, spacer1Top, spacer1Height];
        [NSLayoutConstraint activateConstraints:spacer1LabelConstraints];
        
        
        //photoView
        NSLayoutConstraint *photoViewLeading = [self.photoView.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *photoViewTrailing = [self.photoView.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *photoViewTop = [self.photoView.topAnchor constraintEqualToAnchor: [spacer1 bottomAnchor]];
        NSLayoutConstraint *photoViewHeight = [self.photoView.heightAnchor constraintEqualToConstant:180];
        NSArray *photoViewConstraints = @[photoViewLeading, photoViewTrailing, photoViewTop, photoViewHeight];
        [NSLayoutConstraint activateConstraints:photoViewConstraints];
        

        //captionView
        NSLayoutConstraint *captionViewLeading = [self.captionView.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *captionViewTrailing = [self.captionView.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *captionViewTop = [self.captionView.topAnchor constraintEqualToAnchor: [self.photoView bottomAnchor]];
        NSLayoutConstraint *captionViewHight = [self.captionView.heightAnchor constraintEqualToConstant:30];
        NSArray *captionViewConstraints = @[captionViewLeading, captionViewTrailing, captionViewTop, captionViewHight];
        [NSLayoutConstraint activateConstraints:captionViewConstraints];
    }
    return self;
}



- (void) propagateContentFromPost:(TBLPostPhoto * _Nonnull)post andBlogMeta:(TBLBlogMeta * _Nonnull)blogMeta
{
    [super propagateContentFromPost:post andBlogMeta:blogMeta];
    [self.captionView loadHTMLString:[post captionToHTML] baseURL:nil];
    NSLog(@"Konfiguruję foto.");
}

@end
