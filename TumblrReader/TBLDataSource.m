//
//  TBLDataSource.m
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLDataSource.h"
#import "TBLPostPhoto.h"


int const postsCountPerRequest = 10;


@implementation TBLDataSource

- (nullable instancetype)initWithBlog:(TBLBlogMeta * _Nonnull)blogMeta blogPosts:(NSMutableArray<TBLPost * > * _Nullable)blogPosts
{
    if ((self = [super init]))
    {
        self.blogMeta = blogMeta;
        self.blogPosts = blogPosts;
    }
    return self;
}


- (void) fetchPostsWithCompletionSuccess:(void (^)(NSURLSessionTask * _Nonnull task, TBLBlogMeta * _Nullable blogMeta, NSArray<TBLPost *> * _Nullable posts, NSError * _Nullable error))success
                            failure:(void (^)(NSURLSessionTask * _Nullable task, NSError * _Nonnull error))failure
{
    int startPostIndex = [self postsArrayisEmpty] ? self.blogMeta.startPostIndex : [self nextPostIndex];
    TBLAPIManager *manager = [TBLAPIManager sharedManager];
    [manager fetchPostsForUsername:self.blogMeta.name
                    startPostIndex:startPostIndex
                        postsCount:postsCountPerRequest
                           success:success
                           failure:failure];
}

- (int) nextPostIndex
{
    return self.blogMeta.startPostIndex + postsCountPerRequest;
}

- (BOOL) postsArrayisEmpty
{
    return [self.blogPosts count] == 0;
}

/*
 
 postForRowAtIndexPath
 numberOfRowsInSection
 for (TBLPost *post in posts) {
 NSLog(@"Loaded %u with ID: (%@)", post.type, [TBLPostTypeMap stringForPostType:post.postID]);
 
 }
 */

@end

