//
//  TBLPostPhoto.m
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostPhoto.h"

@implementation TBLPostPhoto

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost
{
    if ((self = [super initWithJSONPost:JSONPost]))
    {
        NSString *caption = [JSONPost objectForKey:@"photo-caption"];
        NSString *photo1280URL = [JSONPost objectForKey:@"photo-url-1280"];
        NSString *photo500URL = [JSONPost objectForKey:@"photo-url-500"];
        if (caption == nil || photo1280URL == nil || photo500URL == nil)
            return nil;
        self.caption = caption;
        self.photo1280URL = photo1280URL;
        self.photo500URL = photo500URL;
        self.width = [[JSONPost objectForKey:@"width"] intValue];
        self.height = [[JSONPost objectForKey:@"height"] intValue];
    }
    return self;
}

- (nonnull NSString*)toHTML
{
    NSString *photoURLString = self.width > 1242 ? self.photo500URL : self.photo1280URL;
    NSString *HTMLImage = [NSString stringWithFormat:@"<img alt=\"\" data-caption=\"\" data-entity-type=\"file\" data-entity-uuid=\"\" src=\"%@\"/>",photoURLString];
    return [NSString stringWithFormat:@"<html><body>%@%@</body></html>",HTMLImage,self.caption];
}

- (nonnull NSString*)captionToHTML
{
    return [NSString stringWithFormat:@"<html><body>%@</body></html>",self.caption];
}

- (nonnull NSString*)iPhoneOptimizedPhotoURL
{
    return (self.width > 1250) ? self.photo500URL : self.photo1280URL;
}

- (BOOL) photoURLsAreNotNil
{
    return (self.photo1280URL != nil && self.photo500URL != nil);
}


@end