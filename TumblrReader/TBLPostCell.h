//
//  TBLPostCell.h
//  TUMBL
//
//  Created by Adam on 13.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
#import <UIKit/UIKit.h>
#import "TBLBlogMeta.h"
#import "TBLPost.h"

@interface TBLPostCell: UITableViewCell

@property UILabel * _Nullable tagsLabel;
@property UILabel * _Nullable dateLabel;
@property UIView * _Nullable titleBox;

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier;
- (void) propageteContentFromPost:(TBLPost * _Nonnull)post andBlogMeta:(TBLBlogMeta * _Nonnull)blogMeta;
- (CGFloat)cellHeight;
@end
