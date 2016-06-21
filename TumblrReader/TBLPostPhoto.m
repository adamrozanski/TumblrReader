//
//  TBLPostPhoto.m
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostPhoto.h"
#import <UIKit/UIKit.h>

@implementation TBLPostPhoto

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost {
    if ((self = [super initWithJSONPost:JSONPost])) {
        NSString *caption = JSONPost[@"photo-caption"];
        NSString *photo1280URL = JSONPost[@"photo-url-1280"];
        NSString *photo500URL = JSONPost[@"photo-url-500"];
        if (!caption || !photo1280URL|| !photo500URL)
            return nil;
        self.caption = caption;
        self.photo1280URL = photo1280URL;
        self.photo500URL = photo500URL;
        self.width = [JSONPost[@"width"] intValue];
        self.height = [JSONPost[@"height"] intValue];
    }
    return self;
}

- (nonnull NSString*)toHTML {
    CGFloat targetWidth = [[UIScreen mainScreen] bounds].size.width-20;
    CGFloat targetHeight = targetWidth * [self photoAspectRatio];
    NSString *htmlString = @"<html><head><meta name='viewport' content='user-scalable=yes,width=device-width'></head><body><img src='%@' width='%f' height='%f' style='max-width:200% max-height:200%'><p>%@</p></body></html>";
    return [[NSString alloc] initWithFormat:htmlString, [self iPhoneOptimizedPhotoURLString], targetWidth, targetHeight, self.caption];
}


- (nonnull NSString*)captionToHTML {
    return [NSString stringWithFormat:@"<html><body>%@</body></html>",self.caption];
}

- (CGFloat) photoAspectRatio {
    return self.height/self.width;
}

- (nonnull NSString*)iPhoneOptimizedPhotoURLString {
    return (self.width > 1250) ? self.photo500URL : self.photo1280URL;
}

- (BOOL) photoURLsAreNotNil {
    return (self.photo1280URL && self.photo500URL);
}

@end