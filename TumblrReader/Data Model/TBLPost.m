//
//  TBLPost.m
//  TumblrReader
//
//  Created by Adam Różański on 10.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLPost.h"
#import "TumblerJSONResponseConsts.h"

@implementation TBLPost

+ (TBLPostType)postTypeForJSONPost:(nonnull NSDictionary *)JSONPost
{
    NSString *stringType = JSONPost[kTumblerJSONPostType];
    return [TBLPostTypeMap.sharedInstance postTypeForString:stringType];
}

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost
{
    if ((self = [super init]))
    {
        NSString *type = JSONPost[kTumblerJSONPostType];
        NSString *date = JSONPost[kTumblerJSONPostDate];
        if (!type || !date)
        {
            return nil;
        }
        self.slug = JSONPost[kTumblerJSONPostSlug];
        self.type = [TBLPostTypeMap.sharedInstance postTypeForString:type];
        self.tags = JSONPost[kTumblerJSONPostTags];
        self.date = date;
    }
    return self;
}

- (nonnull NSString *)toHTML
{
    return @"TBLPost should be subclassed";
}

- (nonnull NSString *)tagsAsString
{
    return (self.tags) ? [self.tags componentsJoinedByString:@" "] : @"brak";
}

@end
