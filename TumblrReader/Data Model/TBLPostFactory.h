//
//  TBLPostFactory.h
//  TumblrReader
//
//  Created by Adam on 12.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"
#import "TBLBlogMeta.h"
#import "TBLQuotePost.h"
#import "TBLPhotoPost.h"
#import "TBLLinkPost.h"
#import "TBLConversationPost.h"
#import "TBLAudioPost.h"
#import "TBLRegularPost.h"
#import "TBLPostTypeMap.h"

@interface TBLPostFactory : NSObject

+ (nullable id)specializedPostFromJSONPost:(nonnull NSDictionary *)JSONPost;

+ (nullable NSArray<TBLPost * > *)postsArrayFromJSONResponse:(nonnull NSDictionary *)JSON;

@end