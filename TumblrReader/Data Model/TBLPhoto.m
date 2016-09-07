//
//  TBLPhoto.m
//  TumblrReader
//
//  Created by Adam Różański on 22.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLPhoto.h"
#import "TumblerJSONResponseConsts.h"

@implementation TBLPhoto

+ (nullable NSArray<TBLPhoto *> *)photoGalleryFromJSONPhotoGallery:(nonnull NSArray *)JSONPhotoGallery
{
    NSMutableArray<TBLPhoto *> *photoGallery = [NSMutableArray array];
    for (NSDictionary *JSONPhoto in JSONPhotoGallery)
    {
        [photoGallery addObject:[[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto]];
    }
    return photoGallery;
}

- (nullable instancetype)initWithJSONPhoto:(nonnull NSDictionary *)JSONPhoto
{
    if (self = [super init])
    {
        NSString *caption = JSONPhoto[kTumblerJSONPhotoCaption];
        if (!caption)
            caption = JSONPhoto[kTumblerJSONPostMainPhotoCaption];
        NSString *photo1280URL = JSONPhoto[kTumblerJSONPhotoURL1280];
        NSString *photo500URL = JSONPhoto[kTumblerJSONPhotoURL500];
        NSString *photo250URL = JSONPhoto[kTumblerJSONPhotoURL250];
        if (!caption || !photo1280URL || !photo500URL || !photo250URL)
        {
            return nil;
        }
        self.caption = caption;
        self.photo1280URL = photo1280URL;
        self.photo500URL = photo500URL;
        self.photo250URL = photo250URL;
        self.width = [JSONPhoto[kTumblerJSONPhotoWidth] integerValue];
        self.height = [JSONPhoto[kTumblerJSONPhotoHeight] integerValue];
    }
    return self;
}

- (nonnull NSString *)toHTML
{
    CGFloat targetWidth = [[UIScreen mainScreen] bounds].size.width - 20;
    CGFloat targetHeight = targetWidth * [self photoAspectRatio];
    NSString *htmlString = @"<p><img src='%@' width='%f' height='%f' style='max-width:200% max-height:200%'></p><p>%@</p>";
    return [NSString stringWithFormat:htmlString, [self iPhoneOptimizedPhotoURLString], targetWidth, targetHeight, self.caption];
}

- (CGFloat)photoAspectRatio
{
    return (CGFloat)self.height / (CGFloat)self.width;
}

- (nonnull NSString *)iPhoneOptimizedPhotoURLString
{
    return (self.width > 1250) ? self.photo500URL : self.photo1280URL;
}

- (nonnull NSString *)captionToHTML
{
    return [NSString stringWithFormat:@"<html><body>%@</body></html>", self.caption];
}

- (BOOL)photoURLsAreNotNil
{
    return (self.photo1280URL && self.photo500URL);
}

@end
