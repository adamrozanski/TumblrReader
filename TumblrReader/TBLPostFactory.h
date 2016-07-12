//
//  TBLPostFactory.h
//  TumblrReader
//
//  Created by Adam on 12.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"
#import "TBLBlogMeta.h"
#import "TBLPostQuote.h"
#import "TBLPostPhoto.h"
#import "TBLPostLink.h"
#import "TBLPostConversation.h"
#import "TBLPostAudio.h"
#import "TBLPostRegular.h"
#import "TBLPostTypeMap.h"

@interface TBLPostFactory : NSObject

+ (nullable id)createSpecializedPostFromJSONPost:(NSDictionary *_Nonnull)JSONPost;

+ (nullable NSArray<TBLPost * > *)postsArrayFromJSONResponse:(NSDictionary *_Nonnull)json;

@end
