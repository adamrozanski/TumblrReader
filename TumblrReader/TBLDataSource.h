//
//  TBLDataSource.h
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "TBLAPIManager.h"
#import "TBLBlogMeta.h"
#import "TBLPost.h"
#import "TBLPostQuote.h"
#import "TBLPostPhoto.h"
#import "TBLPostLink.h"
#import "TBLPostConversation.h"
#import "TBLPostAudio.h"
#import "TBLPostRegular.h"
#import "TBLPostTypeMap.h"

@interface TBLDataSource : NSObject

@property BOOL isFetching;
@property (weak) TBLBlogMeta  * _Nullable blogMeta;
@property (weak) NSMutableArray<TBLPost * > * _Nullable blogPosts;

- (nullable instancetype)initWithBlog:(TBLBlogMeta * _Nonnull)blogMeta blogPosts:(NSMutableArray<TBLPost * > * _Nullable)blogPosts;
- (void) fetchPostsWithCompletionSuccess:(void (^ _Nonnull)(NSURLSessionTask * _Nonnull task, TBLBlogMeta * _Nullable blogMeta, NSArray<TBLPost *> * _Nullable posts, NSError * _Nullable error))success
                                 failure:(void (^ _Nonnull)(NSURLSessionTask * _Nullable task, NSError * _Nonnull error))failure;
- (void) imageFromURLString:(NSString * _Nonnull)URLString
                   success:(void (^ _Nonnull)(UIImage * _Nullable image))success
                   failure:(void (^ _Nonnull)(NSError * _Nonnull error))failure;
@end
