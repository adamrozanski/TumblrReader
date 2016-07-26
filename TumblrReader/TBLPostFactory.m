//
//  TBLPostFactory.m
//  TumblrReader
//
//  Created by Adam on 12.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostFactory.h"

@implementation TBLPostFactory

+ (nullable id)createSpecializedPostFromJSONPost:(NSDictionary *_Nonnull)JSONPost {
    TBLPostType postType = [TBLPost postTypeForJSONPost:JSONPost];
    switch (postType) {
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

+ (nullable NSArray<TBLPost * > *)postsArrayFromJSONResponse:(NSDictionary *_Nonnull)json; {
    NSDictionary *JSONPosts = json[@"posts"];
    NSMutableArray<TBLPost *> *posts = [NSMutableArray array];

    for (NSDictionary *JSONPost in JSONPosts) {
        id post = [TBLPostFactory createSpecializedPostFromJSONPost:JSONPost];
        if (post) {
            [posts addObject:post];
        }
    }
    return [posts copy];
}

@end
