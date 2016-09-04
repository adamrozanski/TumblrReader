//
//  TBLHTMLGenericCell.h
//  TumblrReader
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "TBLPostCell.h"
#import "TBLPost.h"
#import "TBLBlogMeta.h"

@interface TBLHTMLGenericCell : TBLPostCell

@property (strong, nonatomic, nullable) WKWebView *webView;
@property (strong, nonatomic, nullable) NSLayoutConstraint *webViewHeightConstraint;
@property (strong, nonatomic, nullable) NSLayoutConstraint *spacerHeightConstraint;

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

- (void)propagateContentFromPost:(nonnull TBLPost *)post andBlogMeta:(nonnull TBLBlogMeta *)blogMeta;

@end