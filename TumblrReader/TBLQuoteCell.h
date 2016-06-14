//
//  TBLQuoteCell.h
//  TUMBL
//
//  Created by Adam on 13.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//
#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>
#import "TBLPostCell.h"
#import "TBLPostQuote.h"
#import "TBLBlogMeta.h"

@interface TBLQuoteCell : TBLPostCell

@property UILabel * _Nullable quoteLabel;
@property WKWebView * _Nullable sourceWebView;

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier;
- (void) propageteContentFromPost:(TBLPostQuote * _Nonnull)post andBlogMeta:(TBLBlogMeta * _Nonnull)blogMeta;

@end
