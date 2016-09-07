//
//  TBLHTMLGenericCell.h
//  TumblrReader
//
//  Created by Adam Różański on 14.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLBlogMeta.h"
#import "TBLPost.h"
#import "TBLPostCell.h"
#import <WebKit/WebKit.h>

@interface TBLHTMLGenericCell : TBLPostCell

@property (strong, nonatomic, nullable) WKWebView *webView;
@property (strong, nonatomic, nullable) NSLayoutConstraint *webViewHeightConstraint;
@property (strong, nonatomic, nullable) NSLayoutConstraint *spacerHeightConstraint;

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

- (void)propagateContentFromPost:(nonnull TBLPost *)post andBlogMeta:(nonnull TBLBlogMeta *)blogMeta;

@end