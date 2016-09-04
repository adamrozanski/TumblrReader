//
//  TBPhotoCell.h
//  TumblrReader
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "TBLPostCell.h"
#import "TBLPost.h"
#import "TBLPhotoPost.h"

@interface TBLPhotoCell : TBLPostCell

@property (strong, nonatomic, nullable) UIImageView *photoView;
@property (strong, nonatomic, nullable) WKWebView *captionView;

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

- (void)propagateContentFromPost:(nonnull TBLPost *)post andBlogMeta:(nonnull TBLBlogMeta *)blogMeta;

@end
