//
//  TBLPhotoPost.h
//  TumblrReader
//
//  Created by Adam Różański on 11.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLPhoto.h"
#import "TBLPost.h"

@interface TBLPhotoPost : TBLPost

@property (strong, nonatomic, nonnull) TBLPhoto *photo;
@property (strong, nonatomic, nullable) NSArray<TBLPhoto *> *photoGallery;

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost;

- (nonnull NSString *)toHTML;

- (nonnull NSString *)captionToHTML;

- (nonnull NSString *)iPhoneOptimizedPhotoURLString;

- (BOOL)photoURLsAreNotNil;
@end
