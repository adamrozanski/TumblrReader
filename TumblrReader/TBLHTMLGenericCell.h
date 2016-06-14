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

@property WKWebView * _Nullable webView;

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier;
- (void) propagateContentFromPost:(TBLPost * _Nonnull)post andBlogMeta:(TBLBlogMeta * _Nonnull)blogMeta;

@end