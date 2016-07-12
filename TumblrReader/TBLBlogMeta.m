//
//  TBRBlog.m
//  TumblrReader
//
//  Created by Adam on 10.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLBlogMeta.h"

@implementation TBLBlogMeta


- (nonnull instancetype)initWithBlogName:(NSString *_Nonnull)blogName {
    if ((self = [super init])) {
        if (!blogName)
            return nil;
        self.name = blogName;
        self.startPostIndex = 0;
    }
    return self;
}

- (nullable instancetype)initWithJSONResponse:(NSDictionary *_Nullable)json {
    if ((self = [super init])) {
        NSDictionary *tumblelogField = json[@"tumblelog"];
        self.name = tumblelogField[@"name"];
        self.title = tumblelogField[@"title"];

        NSString *startPostIndex = json[@"posts-start"];
        NSString *totalPostsCount = json[@"posts-total"];
        if (!startPostIndex || !totalPostsCount || !self.name || !self.title)
            return nil;
        self.startPostIndex = startPostIndex.intValue;
        self.totalPostsCount = totalPostsCount.intValue;
    }
    return self;
}

@end
