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
        NSLayoutConstraint *titleLabelLeading = [self.titleLabel.leadingAnchor
                constraintEqualToAnchor:[self.titleBox leadingAnchor]
                               constant:4];
        NSLayoutConstraint *titleLabelTailing = [self.titleLabel.trailingAnchor
                constraintEqualToAnchor:[self.titleBox trailingAnchor]];
        NSLayoutConstraint *titleLabelLTop = [self.titleLabel.topAnchor
                constraintEqualToAnchor:[self.titleBox topAnchor]];
        NSLayoutConstraint *titleLabelHeight = [self.titleLabel.heightAnchor
                constraintEqualToAnchor:[self.titleBox heightAnchor]];
        NSArray *titleLabelConstraints = @[
                titleLabelLeading,
                titleLabelTailing,
                titleLabelLTop,
                titleLabelHeight
        ];
        [NSLayoutConstraint activateConstraints:titleLabelConstraints];

        // titleBox
        NSLayoutConstraint *titleBoxLeading = [self.titleBox.leadingAnchor
                constraintEqualToAnchor:[self.contentView leadingAnchor]];
        NSLayoutConstraint *ttitleBoxTailing = [self.titleBox.trailingAnchor
                constraintEqualToAnchor:[self.contentView trailingAnchor]];
        NSLayoutConstraint *titleBoxTop = [self.titleBox.topAnchor
                constraintEqualToAnchor:[self.contentView topAnchor]];
        NSLayoutConstraint *titleBoxHeight =
                [self.titleBox.heightAnchor constraintEqualToConstant:20];
        NSArray *titleBoxConstraints =
                @[titleBoxLeading, ttitleBoxTailing, titleBoxTop, titleBoxHeight];
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
    NSLayoutConstraint *bottomSpacerLeadingAnchor = [bottomSpacer.leadingAnchor
            constraintEqualToAnchor:[self.contentView leadingAnchor]];
    NSLayoutConstraint *bottomSpacerTrailingAnchor = [bottomSpacer.trailingAnchor
            constraintEqualToAnchor:[self.contentView trailingAnchor]];
    NSLayoutConstraint *bottomSpacerTopAnchor =
            [bottomSpacer.topAnchor constraintEqualToAnchor:bottomAnchor];
    NSLayoutConstraint *bottomSpacerHeightAnchor =
            [bottomSpacer.heightAnchor constraintEqualToConstant:0.5];
    NSArray *bottomSpacerLabelConstraints = @[
            bottomSpacerLeadingAnchor,
            bottomSpacerTrailingAnchor,
            bottomSpacerTopAnchor,
            bottomSpacerHeightAnchor
    ];
    [NSLayoutConstraint activateConstraints:bottomSpacerLabelConstraints];

    // footerBox
    NSLayoutConstraint *footerBoxLeadingAnchor = [footerBox.leadingAnchor
            constraintEqualToAnchor:[self.contentView leadingAnchor]];
    NSLayoutConstraint *footerBoxTrailingAnchor = [footerBox.trailingAnchor
            constraintEqualToAnchor:[self.contentView trailingAnchor]];
    NSLayoutConstraint *footerBoxTopAnchor =
            [footerBox.topAnchor constraintEqualToAnchor:[bottomSpacer bottomAnchor]];
    NSLayoutConstraint *footerBoxHeightAnchor =
            [footerBox.heightAnchor constraintEqualToConstant:20];
    NSArray *footerBoxConstraints = @[
            footerBoxLeadingAnchor,
            footerBoxTrailingAnchor,
            footerBoxTopAnchor,
            footerBoxHeightAnchor
    ];
    [NSLayoutConstraint activateConstraints:footerBoxConstraints];

    // footerLabel
    NSLayoutConstraint *footerLabelLeading = [self.footerLabel.leadingAnchor
            constraintEqualToAnchor:[footerBox leadingAnchor]
                           constant:4];
    NSLayoutConstraint *footerLabelTailing = [self.footerLabel.trailingAnchor
            constraintEqualToAnchor:[footerBox trailingAnchor]];
    NSLayoutConstraint *footerLabelLTop = [self.footerLabel.topAnchor
            constraintEqualToAnchor:[footerBox topAnchor]];
    NSLayoutConstraint *footerLabelHeight = [self.footerLabel.heightAnchor
            constraintEqualToAnchor:[footerBox heightAnchor]];
    NSArray *footerLabelConstraints = @[
            footerLabelLeading,
            footerLabelTailing,
            footerLabelLTop,
            footerLabelHeight
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
