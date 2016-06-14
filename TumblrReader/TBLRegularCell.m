//
//  TBLRegularCell.m
//  TUMBL
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLRegularCell.h"

@implementation TBLRegularCell
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.articleWebView = [[WKWebView alloc] init];
        self.articleWebView.userInteractionEnabled = NO;
        [self.articleWebView setBackgroundColor:[UIColor whiteColor]];
        [self.articleWebView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.articleWebView];
        
        // Constraints: (must be here in case of UITableViewCell subclass, not in layoutSubviews)
        
        NSLayoutConstraint *quoteLabelLeading = [self.articleWebView.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *quoteLabelTrailing = [self.articleWebView.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *quoteLabelTop = [self.articleWebView.topAnchor constraintEqualToAnchor: [self.titleBox bottomAnchor]];
        NSLayoutConstraint *quoteLabeleight = [self.articleWebView.heightAnchor constraintEqualToConstant:180];
        NSArray *quoteLabelConstraints = @[quoteLabelLeading, quoteLabelTrailing, quoteLabelTop, quoteLabeleight];
        [NSLayoutConstraint activateConstraints:quoteLabelConstraints];
        
    }
    return self;
}



- (void) propageteContentFromPost:(TBLPostRegular * _Nonnull)post andBlogMeta:(TBLBlogMeta * _Nonnull)blogMeta;
{
    [super propageteContentFromPost:post andBlogMeta:blogMeta];
    [self.articleWebView loadHTMLString: [post toHTMLArticle] baseURL:nil];
    NSLog(@"Konfiguruję regular.");
}

@end
