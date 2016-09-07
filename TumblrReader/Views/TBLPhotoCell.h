//
//  TBPhotoCell.h
//  TumblrReader
//
//  Created by Adam Różański on 14.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//
#import "TBLPhotoPost.h"
#import "TBLPost.h"
#import "TBLPostCell.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface TBLPhotoCell : TBLPostCell

@property (strong, nonatomic, nullable) UIImageView *photoView;
@property (strong, nonatomic, nullable) WKWebView *captionView;

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

- (void)propagateContentFromPost:(nonnull TBLPost *)post andBlogMeta:(nonnull TBLBlogMeta *)blogMeta;

@end
