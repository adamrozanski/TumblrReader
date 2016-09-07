//
//  TBLAPIManager.h
//  TumblrReader
//
//  Created by Adam Różański on 10.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//
#import "TBLAudioPost.h"
#import "TBLBlogMeta.h"
#import "TBLConversationPost.h"
#import "TBLLinkPost.h"
#import "TBLPhotoPost.h"
#import "TBLPost.h"
#import "TBLPostFactory.h"
#import "TBLQuotePost.h"
#import "TBLRegularPost.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TBLAPIManager : NSObject

+ (nonnull TBLAPIManager *)sharedManager;

- (void)fetchPostsForUsername:(nonnull NSString *)username
               startPostIndex:(NSUInteger)startPostIndex
                   postsCount:(NSUInteger)postsCount
                      success:(void (^_Nonnull)(NSURLSessionTask *_Nonnull task,
                                                TBLBlogMeta *_Nullable blogMeta,
                                                NSArray<TBLPost *> *_Nullable posts,
                                                NSError *_Nullable error))success
                      failure:(void (^_Nonnull)(NSURLSessionTask *_Nullable task,
                                                NSError *_Nonnull error))failure;

- (void)imageFromURLString:(nonnull NSString *)URLString
                   success:(void (^_Nonnull)(UIImage *_Nullable image))success
                   failure:(void (^_Nonnull)(NSError *_Nonnull error))failure;

@end
