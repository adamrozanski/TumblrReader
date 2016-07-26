//
//  TBLTableViewDataSource.m
//  TumblrReader
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLTableViewDataSource.h"
#import <PINRemoteImage/PINImageView+PINRemoteImage.h>

static NSUInteger const kPostsCountPerRequest = 20;

@interface TBLTableViewDataSource ()

@end

@implementation TBLTableViewDataSource

- (nullable instancetype)initWithBlogName:(NSString *_Nonnull)blogName {
    if ((self = [super init])) {
        self.blogMeta = [[TBLBlogMeta alloc] initWithBlogName:blogName];
        self.posts = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *_Nonnull)tableView {
    return 1;
}

- (UITableViewCell *_Nonnull)tableView:(UITableView *_Nonnull)tableView
                 cellForRowAtIndexPath:(NSIndexPath *_Nonnull)indexPath {
    TBLPost *post = self.posts[(NSUInteger) indexPath.row];
    NSString *identifier = [TBLPostTypeMap.sharedInstance stringForPostType:post.type];
    TBLPostCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                        forIndexPath:indexPath];
    if ([cell isMemberOfClass:TBLPhotoCell.class]) {
        __weak TBLPhotoPost *photoPost = (TBLPhotoPost *) post;
        __weak TBLPhotoCell *photoCell = (TBLPhotoCell *) cell;
        photoCell.photoView.alpha = 0.0;
        if (photoPost.photoURLsAreNotNil) {
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

// TODO: use "insertCell" instead of "reloadData"
- (void)loadPostsIntoTableView:(UITableView *_Nonnull)tableView
                       success:(void (^ _Nonnull)(NSString *_Nullable errorMessage))success
                       failure:(void (^ _Nonnull)(NSString *_Nonnull errorMessage))failure {
    if (self.isFetchingPosts)
        return;
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
                               if (error) {
                                   self.isFetchingPosts = NO;
                                   [self activityIndicatorEnabled:NO];
                                   success(@"Nie można przetworzyć danych z blogu");
                                   return;
                               }
                               if ([self.posts count] == 0 && [posts count] == 0) {
                                   self.isFetchingPosts = NO;
                                   [self activityIndicatorEnabled:NO];
                                   success(@"Nie ma takiego bloga w Tumblr");
                                   return;
                               }
                               self.isFetchingPosts = NO;
                               [self activityIndicatorEnabled:NO];
                               self.blogMeta.startPostIndex = blogMeta.startPostIndex;
                               self.blogMeta.totalPostsCount = blogMeta.totalPostsCount;
                               [self.posts addObjectsFromArray:posts];
                               [tableView reloadData];
                           }
                           failure:^(NSURLSessionTask *_Nullable task, NSError *_Nonnull error) {
                               self.isFetchingPosts = NO;
                               [self activityIndicatorEnabled:NO];
                               failure(@"Brak połączenia z internetem");
                               return;
                           }];
}

- (NSUInteger)nextPostIndex {
    return self.blogMeta.startPostIndex + kPostsCountPerRequest;
}

- (BOOL)postsArrayIsEmpty {
    return [self.posts count] == 0;
}

- (BOOL)shouldFetchNewPostsForIndexPath:(NSIndexPath *_Nonnull)indexPath {
    NSUInteger rowsLoaded = [self.posts count];
    NSUInteger rowsRemaining = rowsLoaded - indexPath.row;
    NSUInteger rowsToLoadFromBottom = 10;
    return rowsToLoadFromBottom > rowsRemaining;
}

- (void)activityIndicatorEnabled:(BOOL)active {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = active;
}

- (void)imageFromURLString:(NSString *_Nonnull)URLString
                   success:(void (^ _Nonnull)(UIImage *_Nullable image))success
                   failure:(void (^ _Nonnull)(NSError *_Nonnull error))failure {
    TBLAPIManager *manager = [TBLAPIManager sharedManager];
    [manager imageFromURLString:URLString success:success failure:failure];
}

@end
