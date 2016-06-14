//
//  TBLQuoteCell.m
//  TUMBL
//
//  Created by Adam on 13.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLQuoteCell.h"

@implementation TBLQuoteCell 

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILayoutGuide *spacer1 = [[UILayoutGuide alloc] init];
        self.quoteLabel = [[UILabel alloc] init];
        [self.quoteLabel setTextColor:[UIColor colorWithRed:0.24f green:0.39f blue:0.62f alpha:1.0f]];
        [self.quoteLabel setBackgroundColor:[UIColor whiteColor]];
        [self.quoteLabel setFont:[UIFont fontWithName:@"Zapfino" size:12.0f]];
        [self.quoteLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.quoteLabel];
        UILayoutGuide *spacer2 = [[UILayoutGuide alloc] init];
        self.sourceWebView = [[WKWebView alloc] init];
        self.sourceWebView.userInteractionEnabled = NO;
        //self.sourceLabel = [[UILabel alloc] init];
        //[self.sourceLabel setTextColor:[UIColor colorWithRed:0.24f green:0.39f blue:0.62f alpha:1.0f]];
        [self.sourceWebView setBackgroundColor:[UIColor whiteColor]];
        //[self.sourceLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f]];
        [self.sourceWebView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addLayoutGuide:spacer1];
        [self.contentView addSubview:self.quoteLabel];
        [self.contentView addLayoutGuide:spacer2];
        [self.contentView addSubview:self.sourceWebView];

        // Constraints: (must be here in case of UITableViewCell subclass, not in layoutSubviews)
        
        //spacer1
        NSLayoutConstraint *spacer1Leading = [spacer1.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *spacer1Trailing = [spacer1.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *spacer1Top = [spacer1.topAnchor constraintEqualToAnchor: [self.titleBox bottomAnchor]];
        NSLayoutConstraint *spacer1Height = [spacer1.heightAnchor constraintEqualToConstant:10];
        NSArray *spacer1LabelConstraints = @[spacer1Leading, spacer1Trailing, spacer1Top, spacer1Height];
        [NSLayoutConstraint activateConstraints:spacer1LabelConstraints];
        
        
        //quoteLabel
        NSLayoutConstraint *quoteLabelLeading = [self.quoteLabel.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *quoteLabelTrailing = [self.quoteLabel.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *quoteLabelTop = [self.quoteLabel.topAnchor constraintEqualToAnchor: [spacer1 bottomAnchor]];
        NSLayoutConstraint *quoteLabeleight = [self.quoteLabel.heightAnchor constraintEqualToConstant:40];
        NSArray *quoteLabelConstraints = @[quoteLabelLeading, quoteLabelTrailing, quoteLabelTop, quoteLabeleight];
        [NSLayoutConstraint activateConstraints:quoteLabelConstraints];
        
        //spacer2
        NSLayoutConstraint *spacer2BoxLeading = [spacer2.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *spacer2BoxTrailing = [spacer2.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *spacer2BoxTop = [spacer2.topAnchor constraintEqualToAnchor: [self.quoteLabel bottomAnchor]];
        NSLayoutConstraint *spacer2BoxHeight = [spacer2.heightAnchor constraintEqualToConstant:10];
        NSArray *spacer2BoxConstraints = @[spacer2BoxLeading, spacer2BoxTrailing, spacer2BoxTop, spacer2BoxHeight];
        [NSLayoutConstraint activateConstraints:spacer2BoxConstraints];
        
        //sourceLabel
        NSLayoutConstraint *sourceLabelLeading = [self.sourceWebView.leadingAnchor constraintEqualToAnchor: [self.contentView  leadingAnchor]];
        NSLayoutConstraint *sourceLabelTrailing = [self.sourceWebView.trailingAnchor constraintEqualToAnchor: [self.contentView  trailingAnchor]];
        NSLayoutConstraint *sourceLabelTop = [self.sourceWebView.topAnchor constraintEqualToAnchor: [spacer2 bottomAnchor]];
        NSLayoutConstraint *sourceLabeleight = [self.sourceWebView.heightAnchor constraintEqualToConstant:13];
        NSArray *sourceLabelConstraints = @[sourceLabelLeading, sourceLabelTrailing, sourceLabelTop, sourceLabeleight];
        [NSLayoutConstraint activateConstraints:sourceLabelConstraints];
        
   
    }
    return self;
}



- (void) propageteContentFromPost:(TBLPostQuote * _Nonnull)post andBlogMeta:(TBLBlogMeta * _Nonnull)blogMeta;
{
    [super propageteContentFromPost:post andBlogMeta:blogMeta];
    
    self.quoteLabel.text = post.quoteText;
    //self.sourceLabel.text = post.quoteSource;
    [self.sourceWebView loadHTMLString:[NSString stringWithFormat:@"<html><body>%@</body></html>",post.quoteSource] baseURL:nil];
    NSLog(@"Konfiguruję quote.");
}

@end
