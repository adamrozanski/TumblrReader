//
//  TBLTableViewDataSource.m
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLTableViewDataSource.h"
#import <PINRemoteImage/PINRemoteImage.h>
#import <PINRemoteImage/PINImageView+PINRemoteImage.h>

int const postsCountPerRequest = 20;

@interface TBLTableViewDataSource ()

@end

@implementation TBLTableViewDataSource

- (nullable instancetype)initWithBlogName:(NSString * _Nonnull)blogName {
    if ((self = [super init]))
    {
        self.blogMeta = [[TBLBlogMeta alloc] initWithBlogName:blogName];
        self.blogPosts = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blogPosts.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView {
    return 1;
}

- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    TBLPost *post = self.blogPosts[(NSUInteger)indexPath.row];
    NSString *identifier = [TBLPostTypeMap stringForPostType:post.type];
    TBLPostCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:@"photo"]) {
        __weak TBLPostPhoto * photoPost = (TBLPostPhoto *)post;
        __weak TBLPhotoCell * photoCell = (TBLPhotoCell *)cell;
        photoCell.photoView.alpha = 0.0f;
        if (photoPost.photoURLsAreNotNil) {
            NSURL *URL = [NSURL URLWithString:photoPost.iPhoneOptimizedPhotoURLString];
            [photoCell.photoView pin_setImageFromURL:URL completion:^(PINRemoteImageManagerResult * _Nonnull result) {
                if (result.requestDuration > 0.25) {
                    [UIView animateWithDuration:0.3 animations:^{
                        photoCell.photoView.alpha = 1.0f;
                    }];
                } else {
                    [UIView animateWithDuration:0.5 animations:^{
                        photoCell.photoView.alpha = 1.0f;
                    }];
                }
            }];
        }
    }
    [cell propagateContentFromPost:post andBlogMeta:self.blogMeta];
    return cell;
}

#pragma mark - Fetch Data

// TODO: use "insertCell" instead of "reloadData"
- (void) loadPostsIntoTableView:(UITableView * _Nonnull)tableView
              success:(void (^ _Nonnull)(NSString * _Nullable errorMessage))success
              failure:(void (^ _Nonnull)(NSString * _Nonnull errorMessage))failure {
    if (self.isFetchingPosts)
        return;
    self.isFetchingPosts = YES;
    [self activityIndicatorEnabled:YES];
    int startPostIndex = [self postsArrayisEmpty] ? self.blogMeta.startPostIndex : [self nextPostIndex];
    TBLAPIManager *manager = [TBLAPIManager sharedManager];
    [manager fetchPostsForUsername:self.blogMeta.name
                 startPostIndex:startPostIndex
                     postsCount:postsCountPerRequest
                        success:^(NSURLSessionTask * _Nonnull task, TBLBlogMeta * _Nullable blogMeta, NSArray<TBLPost *> * _Nullable posts, NSError * _Nullable error) {
        if (error) {
            self.isFetchingPosts = NO;
            [self activityIndicatorEnabled:NO];
            success(@"Nie można przetworzyć danych z blogu");
            return;
        }
        if ([self.blogPosts count] == 0 && [posts count] == 0) {
            self.isFetchingPosts = NO;
            [self activityIndicatorEnabled:NO];
            success(@"Nie ma takiego bloga w Tumblr");
            return;
        }
        self.isFetchingPosts = NO;
        [self activityIndicatorEnabled:NO];
        self.blogMeta.startPostIndex = blogMeta.startPostIndex;
        self.blogMeta.totalPostsCount = blogMeta.totalPostsCount;
        [self.blogPosts addObjectsFromArray:posts];
        [tableView reloadData];
    } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
        self.isFetchingPosts = NO;
        [self activityIndicatorEnabled:NO];
        failure(@"Brak połączenia z internetem");
        return;
    }];
}
- (int) nextPostIndex {
    return self.blogMeta.startPostIndex + postsCountPerRequest;
}

- (BOOL) postsArrayisEmpty {
    return [self.blogPosts count] == 0;
}

- (BOOL) shouldFetchNewPostsForIndexPath:(NSIndexPath * _Nonnull)indexPath {
    long rowsLoaded = (long)[self.blogPosts count];
    long rowsRemaining = rowsLoaded - (long)indexPath.row;
    long rowsToLoadFromBottom = 10;
    return (rowsRemaining <= rowsToLoadFromBottom);
}

- (void) activityIndicatorEnabled:(BOOL)active {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = active;
}

-(void) imageFromURLString:(NSString * _Nonnull)URLString
                   success:(void (^ _Nonnull)(UIImage * _Nullable image))success
                   failure:(void (^ _Nonnull)(NSError * _Nonnull error))failure {
    TBLAPIManager *manager = [TBLAPIManager sharedManager];
    [manager imageFromURLString:URLString
                        success:success
                        failure:failure];
}

@end

