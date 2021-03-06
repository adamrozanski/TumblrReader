//
//  TBLTableViewDataSource.m
//  TumblrReader
//
//  Created by Adam Różański on 11.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLTableViewDataSource.h"
#import <PINRemoteImage/PINImageView+PINRemoteImage.h>

static NSUInteger const kPostsCountPerRequest = 20;

@interface TBLTableViewDataSource ()

@end

@implementation TBLTableViewDataSource

- (nullable instancetype)initWithBlogName:(nonnull NSString *)blogName
{
    if ((self = [super init]))
    {
        self.blogMeta = [[TBLBlogMeta alloc] initWithBlogName:blogName];
        self.posts = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.posts.count;
}

- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView
{
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    TBLPost *post = self.posts[indexPath.row];
    NSString *identifier = [TBLPostTypeMap.sharedInstance stringForPostType:post.type];
    TBLPostCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                        forIndexPath:indexPath];
    if ([cell isMemberOfClass:TBLPhotoCell.class])
    {
        __weak TBLPhotoPost *photoPost = (TBLPhotoPost *)post;
        __weak TBLPhotoCell *photoCell = (TBLPhotoCell *)cell;
        photoCell.photoView.alpha = 0.0;
        if (photoPost.photoURLsAreNotNil)
        {
            NSURL *URL = [NSURL URLWithString:photoPost.iPhoneOptimizedPhotoURLString];
            [photoCell.photoView pin_setImageFromURL:URL
                                          completion:^(PINRemoteImageManagerResult *_Nonnull result) {
                                            NSTimeInterval duration = result.requestDuration > 0.25 ? 0.3 : 0.5;
                                            [UIView animateWithDuration:duration
                                                             animations:^{
                                                               photoCell.photoView.alpha = 1.0;
                                                             }];
                                          }];
        }
    }
    [cell propagateContentFromPost:post andBlogMeta:self.blogMeta];
    return cell;
}

#pragma mark - Load Content

- (void)loadPostsIntoTableView:(nonnull UITableView *)tableView
                       success:(void (^_Nonnull)())success
                       failure:(void (^_Nonnull)(NSString *_Nonnull errorMessage))failure
{
    if (self.isFetchingPosts)
    {
        return;
    }
    self.isFetchingPosts = YES;
    [self activityIndicatorEnabled:YES];
    NSUInteger startPostIndex = [self postsArrayIsEmpty] ? self.blogMeta.startPostIndex : [self nextPostIndex];
    TBLAPIManager *manager = [TBLAPIManager sharedManager];
    [manager fetchPostsForUsername:self.blogMeta.name
        startPostIndex:startPostIndex
        postsCount:kPostsCountPerRequest
        success:^(NSURLSessionTask *_Nonnull task,
                  TBLBlogMeta *_Nullable blogMeta,
                  NSArray<TBLPost *> *_Nullable posts, NSError *_Nullable error) {
          if (error)
          {
              self.isFetchingPosts = NO;
              [self activityIndicatorEnabled:NO];
              failure(@"Nie można przetworzyć danych z blogu");
              return;
          }
          if ([self postsArrayIsEmpty] && [posts count] == 0)
          {
              self.isFetchingPosts = NO;
              [self activityIndicatorEnabled:NO];
              failure(@"Nie ma takiego bloga w Tumblr");
              return;
          }
            self.isFetchingPosts = NO;
            [self activityIndicatorEnabled:NO];
            self.blogMeta.startPostIndex = blogMeta.startPostIndex;
            self.blogMeta.totalPostsCount = blogMeta.totalPostsCount;
            [self addPosts:posts toTableView:tableView withStartPostIndex:startPostIndex];
          success();
        }
        failure:^(NSURLSessionTask *_Nullable task, NSError *_Nonnull error) {
          self.isFetchingPosts = NO;
          [self activityIndicatorEnabled:NO];
          failure(@"Brak połączenia z internetem");
          return;
        }];
}

- (void)addPosts:(NSArray<TBLPost *> *)posts toTableView:(UITableView *)tableView withStartPostIndex:(NSUInteger)startPostIndex {
    if (startPostIndex < kPostsCountPerRequest) {
        [self.posts addObjectsFromArray:posts];
        [tableView reloadData];
    } else {
        NSMutableArray *indexPaths = [NSMutableArray array];
        NSInteger currentCount = self.posts.count;
        for (int i = 0; i < posts.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:currentCount+i inSection:0]];
        }
        [self.posts addObjectsFromArray:posts];
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        [tableView endUpdates];
    }
}

- (NSUInteger)nextPostIndex
{
    return self.blogMeta.startPostIndex + kPostsCountPerRequest;
}

- (BOOL)postsArrayIsEmpty
{
    return [self.posts count] == 0;
}

- (BOOL)shouldFetchNewPostsForIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSUInteger rowsLoaded = [self.posts count];
    NSUInteger rowsRemaining = rowsLoaded - indexPath.row;
    NSUInteger rowsToLoadFromBottom = 10;
    return rowsToLoadFromBottom > rowsRemaining;
}

- (void)activityIndicatorEnabled:(BOOL)active
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = active;
}

- (void)imageFromURLString:(nonnull NSString *)URLString
                   success:(void (^_Nonnull)(UIImage *_Nullable image))success
                   failure:(void (^_Nonnull)(NSError *_Nonnull error))failure
{
    TBLAPIManager *manager = [TBLAPIManager sharedManager];
    [manager imageFromURLString:URLString success:success failure:failure];
}

@end
