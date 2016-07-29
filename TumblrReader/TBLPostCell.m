//
//  TBLPostCell.m
//  TumblrReader
//
//  Created by Adam on 13.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostCell.h"

@implementation TBLPostCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(NSString *_Nullable)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =
                [UIColor colorWithRed:0.21 green:0.24 blue:0.28 alpha:1.0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setTextColor:[UIColor colorWithRed:0.21
                                                      green:0.24
                                                       blue:0.28
                                                      alpha:1.0]];
        [self.titleLabel setBackgroundColor:[UIColor whiteColor]];
        [self.titleLabel
                setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0]];
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.titleBox = [[UIView alloc] init];
        [self.titleBox setBackgroundColor:[UIColor whiteColor]];
        [self.titleBox setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.titleBox addSubview:self.titleLabel];
        [self.contentView addSubview:self.titleBox];

        // Constraints: (must be here in case of UITableViewCell subclass, not in
        // layoutSubviews)

        // titleLabel
        NSLayoutConstraint *titleLabelLeadingConstraint = [self.titleLabel.leadingAnchor
                constraintEqualToAnchor:[self.titleBox leadingAnchor]
                               constant:4];
        NSLayoutConstraint *titleLabelTailingConstraint = [self.titleLabel.trailingAnchor
                constraintEqualToAnchor:[self.titleBox trailingAnchor]];
        NSLayoutConstraint *titleLabelTopConstraint = [self.titleLabel.topAnchor
                constraintEqualToAnchor:[self.titleBox topAnchor]];
        NSLayoutConstraint *titleLabelHeightConstraint = [self.titleLabel.heightAnchor
                constraintEqualToAnchor:[self.titleBox heightAnchor]];
        NSArray *titleLabelConstraints = @[
                titleLabelLeadingConstraint,
                titleLabelTailingConstraint,
                titleLabelTopConstraint,
                titleLabelHeightConstraint
        ];
        [NSLayoutConstraint activateConstraints:titleLabelConstraints];

        // titleBox
        NSLayoutConstraint *titleBoxLeadingConstraint = [self.titleBox.leadingAnchor
                constraintEqualToAnchor:[self.contentView leadingAnchor]];
        NSLayoutConstraint *titleBoxTailingConstraint = [self.titleBox.trailingAnchor
                constraintEqualToAnchor:[self.contentView trailingAnchor]];
        NSLayoutConstraint *titleBoxTopConstraint = [self.titleBox.topAnchor
                constraintEqualToAnchor:[self.contentView topAnchor]];
        NSLayoutConstraint *titleBoxHeightConstraint =
                [self.titleBox.heightAnchor constraintEqualToConstant:20];
        NSArray *titleBoxConstraints =
                @[titleBoxLeadingConstraint, titleBoxTailingConstraint, titleBoxTopConstraint, titleBoxHeightConstraint];
        [NSLayoutConstraint activateConstraints:titleBoxConstraints];
    }
    return self;
}

- (void)attachFooterToBottomAnchor:(NSLayoutYAxisAnchor *_Nonnull)bottomAnchor {
    UILayoutGuide *bottomSpacer = [[UILayoutGuide alloc] init];
    self.footerLabel = [[UILabel alloc] init];
    [self.footerLabel setTextColor:[UIColor colorWithRed:0.21 green:0.24 blue:0.28 alpha:1.0]];
    [self.footerLabel setBackgroundColor:[UIColor whiteColor]];
    [self.footerLabel  setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0]];
    [self.footerLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    UIView *footerBox = [[UIView alloc] init];
    [footerBox setBackgroundColor:[UIColor whiteColor]];
    [footerBox setTranslatesAutoresizingMaskIntoConstraints:NO];
    [footerBox addSubview:self.footerLabel];
    [self.contentView addSubview:footerBox];
    [self.contentView addLayoutGuide:bottomSpacer];

    // Constraints: (must be here in case of UITableViewCell subclass, not in
    // layoutSubviews)

    // spacer
    NSLayoutConstraint *bottomSpacerLeadingConstraint = [bottomSpacer.leadingAnchor
            constraintEqualToAnchor:[self.contentView leadingAnchor]];
    NSLayoutConstraint *bottomSpacerTrailingConstraint = [bottomSpacer.trailingAnchor
            constraintEqualToAnchor:[self.contentView trailingAnchor]];
    NSLayoutConstraint *bottomSpacerTopConstraint =
            [bottomSpacer.topAnchor constraintEqualToAnchor:bottomAnchor];
    NSLayoutConstraint *bottomSpacerHeightConstraint =
            [bottomSpacer.heightAnchor constraintEqualToConstant:0.5];
    NSArray *bottomSpacerLabelConstraints = @[
            bottomSpacerLeadingConstraint,
            bottomSpacerTrailingConstraint,
            bottomSpacerTopConstraint,
            bottomSpacerHeightConstraint
    ];
    [NSLayoutConstraint activateConstraints:bottomSpacerLabelConstraints];

    // footerBox
    NSLayoutConstraint *footerBoxLeadingConstraint = [footerBox.leadingAnchor
            constraintEqualToAnchor:[self.contentView leadingAnchor]];
    NSLayoutConstraint *footerBoxTrailingConstraint = [footerBox.trailingAnchor
            constraintEqualToAnchor:[self.contentView trailingAnchor]];
    NSLayoutConstraint *footerBoxTopConstraint =
            [footerBox.topAnchor constraintEqualToAnchor:[bottomSpacer bottomAnchor]];
    NSLayoutConstraint *footerBoxHeightConstraint =
            [footerBox.heightAnchor constraintEqualToConstant:20];
    NSArray *footerBoxConstraints = @[
            footerBoxLeadingConstraint,
            footerBoxTrailingConstraint,
            footerBoxTopConstraint,
            footerBoxHeightConstraint
    ];
    [NSLayoutConstraint activateConstraints:footerBoxConstraints];

    // footerLabel
    NSLayoutConstraint *footerLabelLeadingConstraint = [self.footerLabel.leadingAnchor
            constraintEqualToAnchor:[footerBox leadingAnchor]
                           constant:4];
    NSLayoutConstraint *footerLabelTrailingConstraint = [self.footerLabel.trailingAnchor
            constraintEqualToAnchor:[footerBox trailingAnchor]];
    NSLayoutConstraint *footerLabelTopConstraint = [self.footerLabel.topAnchor
            constraintEqualToAnchor:[footerBox topAnchor]];
    NSLayoutConstraint *footerLabelHeightConstraint = [self.footerLabel.heightAnchor
            constraintEqualToAnchor:[footerBox heightAnchor]];
    NSArray *footerLabelConstraints = @[
            footerLabelLeadingConstraint,
            footerLabelTrailingConstraint,
            footerLabelTopConstraint,
            footerLabelHeightConstraint
    ];
    [NSLayoutConstraint activateConstraints:footerLabelConstraints];
}

- (void)propagateContentFromPost:(TBLPost *_Nonnull)post
                     andBlogMeta:(TBLBlogMeta *_Nonnull)blogMeta {
    self.titleLabel.text = post.date;
    self.footerLabel.text =
            [NSString stringWithFormat:@"Tagi: %@", [post tagsAsString]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];
}

@end
