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
        case Quote:
            return [[TBLPostQuote alloc] initWithJSONPost:JSONPost];
        case Photo:
            return [[TBLPostPhoto alloc] initWithJSONPost:JSONPost];
        case Link:
            return [[TBLPostLink alloc] initWithJSONPost:JSONPost];
        case Conversation:
            return [[TBLPostConversation alloc] initWithJSONPost:JSONPost];
        case Audio:
            return [[TBLPostAudio alloc] initWithJSONPost:JSONPost];
        case Regular:
            return [[TBLPostRegular alloc] initWithJSONPost:JSONPost];
        default:
            return nil;
    }
}

+ (nullable NSArray<TBLPost * >*) postsArrayFromJSONResponse: (NSDictionary * _Nonnull)json; {
    NSDictionary *JSONPosts = [json objectForKey:@"posts"];
    NSMutableArray<TBLPost*> *posts = [NSMutableArray array];
    
    for (NSDictionary *JSONPost in JSONPosts) {
        id post = [TBLPostFactory createSpecializedPostFromJSONPost:JSONPost];
        if (post != nil) {
            [posts addObject: post];
        }
    }
    return posts;
}

@end
