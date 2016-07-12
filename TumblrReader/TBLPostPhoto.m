//
//  TBLPostPhoto.m
//  TumblrReader
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostPhoto.h"

@implementation TBLPostPhoto

- (nullable instancetype)initWithJSONPost:(NSDictionary *_Nonnull)JSONPost {
    if ((self = [super initWithJSONPost:JSONPost])) {
        TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPost];
        if (!photo)
            return nil;
        self.photo = photo;
        NSArray<TBLPhoto *> *JSONPhotoGallery = JSONPost[@"photos"];
        self.photoGallery = [TBLPhoto photoGalleryFromJSONPhotoGallery:JSONPhotoGallery];
    }
    return self;
}

- (nonnull NSString *)toHTML {
    NSString *HTMLString = @"<html><head><meta name='viewport' content='user-scalable=yes,width=device-width'></head><body>%@%@</body></html>";
    return [NSString stringWithFormat:HTMLString, [self photoToHTML], [self photoGalleryToHTML]];
}

- (nullable NSString *)photoToHTML {
    return [self.photo toHTML];
}

- (nullable NSString *)photoGalleryToHTML {
    NSMutableString *HTMLString = [NSMutableString string];
    if (!self.photoGallery || [self.photoGallery count] == 0)
        return HTMLString;
    for (TBLPhoto *photo in self.photoGallery) {
        [HTMLString appendString:photo.toHTML];
    }
    return HTMLString;
}

- (nonnull NSString *)captionToHTML {
    return [self.photo captionToHTML];
}

- (nonnull NSString *)iPhoneOptimizedPhotoURLString {
    return self.photo.iPhoneOptimizedPhotoURLString;
}

- (BOOL)photoURLsAreNotNil {
    return self.photo.photoURLsAreNotNil;
}

@end