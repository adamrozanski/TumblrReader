//
//  TBLPostFactory.m
//  TumblrReader
//
//  Created by Adam Różański on 12.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLPostFactory.h"

@implementation TBLPostFactory

+ (nullable id)specializedPostFromJSONPost:(nonnull NSDictionary *)JSONPost
{
    TBLPostType postType = [TBLPost postTypeForJSONPost:JSONPost];
    switch (postType)
    {
        case TBLPostTypeQuote:
            return [[TBLQuotePost alloc] initWithJSONPost:JSONPost];
        case TBLPostTypePhoto:
            return [[TBLPhotoPost alloc] initWithJSONPost:JSONPost];
        case TBLPostTypeLink:
            return [[TBLLinkPost alloc] initWithJSONPost:JSONPost];
        case TBLPostTypeConversation:
            return [[TBLConversationPost alloc] initWithJSONPost:JSONPost];
        case TBLPostTypeAudio:
            return [[TBLAudioPost alloc] initWithJSONPost:JSONPost];
        case TBLPostTypeRegular:
            return [[TBLRegularPost alloc] initWithJSONPost:JSONPost];
        default:
            return nil;
    }
}

+ (nullable NSArray<TBLPost *> *)postsArrayFromJSONResponse:(nonnull NSDictionary *)JSON;
{
    NSDictionary *JSONPosts = JSON[@"posts"];
    NSMutableArray<TBLPost *> *posts = [NSMutableArray array];

    for (NSDictionary *JSONPost in JSONPosts)
    {
        id post = [TBLPostFactory specializedPostFromJSONPost:JSONPost];
        if (post)
        {
            [posts addObject:post];
        }
    }
    return [posts copy];
}

@end
