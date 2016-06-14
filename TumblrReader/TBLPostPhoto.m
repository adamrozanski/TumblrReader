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
        NSString *photoURL = [JSONPost objectForKey:@"photo-url-1280"];
        if (caption == nil || photoURL == nil)
            return nil;
        self.caption = caption;
        self.photoURL = photoURL;
        self.width = [[JSONPost objectForKey:@"width"] intValue];
        self.height = [[JSONPost objectForKey:@"height"] intValue];
    }
    return self;
}

@end