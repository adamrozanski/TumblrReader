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
        [self.imageView setBackgroundColor:[UIColor yellowColor]];
        [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        UILayoutGuide *spacer2 = [[UILayoutGuide alloc] init];
        [self.textLabel setTextColor:[UIColor colorWithRed:0.24f green:0.39f blue:0.62f alpha:1.0f]];
        [self.textLabel setBackgroundColor:[UIColor whiteColor]];
        [self.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f]];
        [self.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addLayoutGuide:spacer1];
        [self.contentView addSubview:self.imageView];
        [self.contentView addLayoutGuide:spacer2];
        [self.contentView addSubview:self.textLabel];
        
        // Constraints: (must be here in case of UITableViewCell subclass, not in layoutSubviews)
        
        //spacer1
        NSLayoutConstraint *spacer1Leading = [spacer1.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *spacer1Trailing = [spacer1.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *spacer1Top = [spacer1.topAnchor constraintEqualToAnchor: [self.titleBox bottomAnchor]];
        NSLayoutConstraint *spacer1Height = [spacer1.heightAnchor constraintEqualToConstant:10];
        NSArray *spacer1LabelConstraints = @[spacer1Leading, spacer1Trailing, spacer1Top, spacer1Height];
        [NSLayoutConstraint activateConstraints:spacer1LabelConstraints];
        
        
        //imageView
        NSLayoutConstraint *imageViewLeading = [self.imageView.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *imageViewTrailing = [self.imageView.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *imageViewTop = [self.imageView.topAnchor constraintEqualToAnchor: [spacer1 bottomAnchor]];
        NSLayoutConstraint *imageViewHeight = [self.imageView.heightAnchor constraintEqualToConstant:40];
        NSArray *imageViewConstraints = @[imageViewLeading, imageViewTrailing, imageViewTop, imageViewHeight];
        [NSLayoutConstraint activateConstraints:imageViewConstraints];
        
        //spacer2
        NSLayoutConstraint *spacer2BoxLeading = [spacer2.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *spacer2BoxTrailing = [spacer2.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *spacer2BoxTop = [spacer2.topAnchor constraintEqualToAnchor:[self.imageView bottomAnchor]];
        NSLayoutConstraint *spacer2BoxHeight = [spacer2.heightAnchor constraintEqualToConstant:10];
        NSArray *spacer2BoxConstraints = @[spacer2BoxLeading, spacer2BoxTrailing, spacer2BoxTop, spacer2BoxHeight];
        [NSLayoutConstraint activateConstraints:spacer2BoxConstraints];
        
        //textLabel
        NSLayoutConstraint *textLabelLeading = [self.textLabel.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *textLabelTrailing = [self.textLabel.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *textLabelTop = [self.textLabel.topAnchor constraintEqualToAnchor: [spacer2 bottomAnchor]];
        NSLayoutConstraint *textLabelHight = [self.textLabel.heightAnchor constraintEqualToConstant:13];
        NSArray *textLabelConstraints = @[textLabelLeading, textLabelTrailing, textLabelTop, textLabelHight];
        [NSLayoutConstraint activateConstraints:textLabelConstraints];
        
        
    }
    return self;
}



- (void) propagateContentFromPost:(TBLPostPhoto * _Nonnull)post andBlogMeta:(TBLBlogMeta * _Nonnull)blogMeta
{
    [super propagateContentFromPost:post andBlogMeta:blogMeta];
    
    self.textLabel.text = post.caption;
    
    //self.imageView = post.quoteSource;
    NSLog(@"Konfiguruję quote.");
}

@end
