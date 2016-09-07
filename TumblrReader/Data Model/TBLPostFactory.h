//
//  TBLPostFactory.h
//  TumblrReader
//
//  Created by Adam Różański on 12.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLAudioPost.h"
#import "TBLBlogMeta.h"
#import "TBLConversationPost.h"
#import "TBLLinkPost.h"
#import "TBLPhotoPost.h"
#import "TBLPost.h"
#import "TBLPostTypeMap.h"
#import "TBLQuotePost.h"
#import "TBLRegularPost.h"

@interface TBLPostFactory : NSObject

+ (nullable id)specializedPostFromJSONPost:(nonnull NSDictionary *)JSONPost;

+ (nullable NSArray<TBLPost *> *)postsArrayFromJSONResponse:(nonnull NSDictionary *)JSON;

@end
