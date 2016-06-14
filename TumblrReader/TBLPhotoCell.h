//
//  TBPhotoCell.h
//  TUMBL
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TBLTableViewCellFactory.h"
#import "TBLPostCell.h"
#import "TBLPost.h"

@interface TBLPhotoCell : TBLPostCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier;
- (void) propageteContentFromPost:(TBLPostPhoto * _Nonnull)post andBlogMeta:(TBLBlogMeta * _Nonnull)blogMeta;

@end
