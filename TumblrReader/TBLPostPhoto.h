//
//  TBLPostPhoto.h
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"
#import "TBLPhoto.h"

@interface TBLPostPhoto : TBLPost

@property (nonnull) TBLPhoto *photo;
@property (nullable) NSArray<TBLPhoto *> *photoGallery;

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost;
- (nonnull NSString*)toHTML;
- (nonnull NSString*)captionToHTML;
- (nonnull NSString*)iPhoneOptimizedPhotoURLString;
- (BOOL) photoURLsAreNotNil;
@end

