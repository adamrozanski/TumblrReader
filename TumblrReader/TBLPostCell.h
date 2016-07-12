//
//  TBLPostCell.h
//  TumblrReader
//
//  Created by Adam on 13.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
#import <UIKit/UIKit.h>
#import "TBLBlogMeta.h"
#import "TBLPost.h"

@interface TBLPostCell : UITableViewCell

@property UILabel *_Nullable titleLabel;
@property UIView *_Nullable titleBox;
@property UILabel *_Nullable footerLabel;

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *_Nullable)reuseIdentifier;

- (void)attachFooterToBottomAnchor:(NSLayoutYAxisAnchor *_Nonnull)bottomAnchor;

- (void)propagateContentFromPost:(TBLPost *_Nonnull)post andBlogMeta:(TBLBlogMeta *_Nonnull)blogMeta;

@end
