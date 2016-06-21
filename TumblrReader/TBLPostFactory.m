//
//  TBLPostFactory.m
//  TUMBL
//
//  Created by Adam on 12.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostFactory.h"

@implementation TBLPostFactory

+ (nullable id) createSpecializedPostFromJSONPost:(NSDictionary * _Nonnull)JSONPost {
    TBLPostType postType = [TBLPost postTypeForJSONPost:JSONPost];
    switch (postType) {
        case TBLPostTypeQuote:
            return [[TBLPostQuote alloc] initWithJSONPost:JSONPost];
        case TBLPostTypePhoto:
            return [[TBLPostPhoto alloc] initWithJSONPost:JSONPost];
        case TBLPostTypeLink:
            return [[TBLPostLink alloc] initWithJSONPost:JSONPost];
        case TBLPostTypeConversation:
            return [[TBLPostConversation alloc] initWithJSONPost:JSONPost];
        case TBLPostTypeAudio:
            return [[TBLPostAudio alloc] initWithJSONPost:JSONPost];
        case TBLPostTypeRegular:
            return [[TBLPostRegular alloc] initWithJSONPost:JSONPost];
        default:
            return nil;
    }
}

+ (nullable NSArray<TBLPost * >*) postsArrayFromJSONResponse: (NSDictionary * _Nonnull)json; {
    NSDictionary *JSONPosts = json[@"posts"];
    NSMutableArray<TBLPost*> *posts = [NSMutableArray array];
    
    for (NSDictionary *JSONPost in JSONPosts) {
        id post = [TBLPostFactory createSpecializedPostFromJSONPost:JSONPost];
        if (post) {
            [posts addObject: post];
        }
    }
    return posts;
}

@end
