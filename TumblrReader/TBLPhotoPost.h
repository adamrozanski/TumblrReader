//
//  TBLPhotoPost.h
//  TumblrReader
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"
#import "TBLPhoto.h"

@interface TBLPhotoPost : TBLPost

@property (strong, nonatomic, nonnull) TBLPhoto *photo;
@property (strong, nonatomic, nullable) NSArray<TBLPhoto *> *photoGallery;

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost;

- (nonnull NSString *)toHTML;

- (nonnull NSString *)captionToHTML;

- (nonnull NSString *)iPhoneOptimizedPhotoURLString;

- (BOOL)photoURLsAreNotNil;
@end

