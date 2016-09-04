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

@property (strong, nonatomic, nullable) UILabel *titleLabel;
@property (strong, nonatomic, nullable) UIView *titleBox;
@property (strong, nonatomic, nullable) UILabel *footerLabel;

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *_Nullable)reuseIdentifier;

- (void)attachFooterToBottomAnchor:(nonnull NSLayoutYAxisAnchor *)bottomAnchor;

- (void)propagateContentFromPost:(nonnull TBLPost *)post andBlogMeta:(nonnull TBLBlogMeta *)blogMeta;

@end
