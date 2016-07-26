//
//  TBLPhoto.h
//  TumblrReader
//
//  Created by Adam on 22.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBLPhoto : NSObject

@property NSString *_Nullable caption;
@property NSUInteger width;
@property NSUInteger height;
@property NSString *_Nullable photo1280URL;
@property NSString *_Nullable photo500URL;
@property NSString *_Nullable photo250URL;

+ (nullable NSArray<TBLPhoto *> *)photoGalleryFromJSONPhotoGallery:(NSArray *_Nonnull)JSONPhotoGallery;

- (nullable instancetype)initWithJSONPhoto:(NSDictionary *_Nonnull)JSONPhoto;

- (nonnull NSString *)toHTML;

- (nonnull NSString *)captionToHTML;

- (nonnull NSString *)iPhoneOptimizedPhotoURLString;

- (CGFloat)photoAspectRatio;

- (BOOL)photoURLsAreNotNil;
@end
