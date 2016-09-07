//
//  TBRBlog.m
//  TumblrReader
//
//  Created by Adam Różański on 10.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLBlogMeta.h"
#import "TumblerJSONResponseConsts.h"

@implementation TBLBlogMeta

- (nonnull instancetype)initWithBlogName:(nonnull NSString *)blogName
{
    if ((self = [super init]))
    {
        if (!blogName)
        {
            return nil;
        }
        self.name = blogName;
        self.startPostIndex = 0;
    }
    return self;
}

- (nullable instancetype)initWithJSONResponse:(nonnull NSDictionary *)json
{
    if ((self = [super init]))
    {
        NSDictionary *tumblelogField = json[kTumblerJSONTumblelog];
        self.name = tumblelogField[kTumblerJSONTumblelogBlogName];
        self.title = tumblelogField[kTumblerJSONTumblelogBlogTitle];

        NSString *startPostIndex = json[kTumblerJSONBlogStartPostIndex];
        NSString *totalPostsCount = json[kTumblerJSONBlogTotalPostsCount];
        if (!startPostIndex || !totalPostsCount || !self.name || !self.title)
        {
            return nil;
        }
        self.startPostIndex = startPostIndex.integerValue;
        self.totalPostsCount = totalPostsCount.integerValue;
    }
    return self;
}

@end
