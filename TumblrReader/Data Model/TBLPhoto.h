//
//  TBLPhoto.h
//  TumblrReader
//
//  Created by Adam on 22.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBLPhoto : NSObject

@property (strong, nonatomic, nullable) NSString *caption;
@property (assign, nonatomic) NSUInteger width;
@property (assign, nonatomic) NSUInteger height;
@property (strong, nonatomic, nullable) NSString *photo1280URL;
@property (strong, nonatomic, nullable) NSString *photo500URL;
@property (strong, nonatomic, nullable) NSString *photo250URL;

+ (nullable NSArray<TBLPhoto *> *)photoGalleryFromJSONPhotoGallery:(nonnull NSArray *)JSONPhotoGallery;

- (nullable instancetype)initWithJSONPhoto:(nonnull NSDictionary *)JSONPhoto;

- (nonnull NSString *)toHTML;

- (nonnull NSString *)captionToHTML;

- (nonnull NSString *)iPhoneOptimizedPhotoURLString;

- (CGFloat)photoAspectRatio;

- (BOOL)photoURLsAreNotNil;
@end
