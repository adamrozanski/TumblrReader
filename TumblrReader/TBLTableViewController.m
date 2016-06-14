//
//  ViewController.m
//  TumblrReader
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLTableViewController.h"

#import <PINRemoteImage/PINRemoteImage.h>
#import <PINRemoteImage/PINImageView+PINRemoteImage.h>
#import <PINCache/PINCache.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>

@interface TBLTableViewController () <UITableViewDelegate,UITableViewDataSource>

@property TBLBlogMeta * _Nullable blogMeta;
@property NSMutableArray<TBLPost * > * _Nullable blogPosts;
@property TBLDataSource * _Nullable dataSource;
@property BOOL isFetchingPosts;

@end

@implementation TBLTableViewController

#pragma mark - Initial Section

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureTableView];
    [self setupData];
    [self loadPosts];
    [self configureNavigationContolller];
    [self setupRefreshControl];
    
}

-(void) configureTableView
{
    self.tableView.estimatedRowHeight = 400.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.24f green:0.39f blue:0.62f alpha:1.0f];
    [self.tableView registerClass:[TBLQuoteCell class] forCellReuseIdentifier:@"quote"];
    [self.tableView registerClass:[TBLPhotoCell class] forCellReuseIdentifier:@"photo"];
    [self.tableView registerClass:[TBLRegularCell class] forCellReuseIdentifier:@"regular"];
    [self.tableView registerClass:[TBLAudioCell class] forCellReuseIdentifier:@"audio"];
    [self.tableView registerClass:[TBLConversationCell class] forCellReuseIdentifier:@"conversation"];
    [self.tableView registerClass:[TBLLinkCell class] forCellReuseIdentifier:@"link"];
}

- (void) updateBlogTitle
{
    self.title = (self.blogMeta == nil) ? @"Tumblr Reader" : self.blogMeta.name;
}

- (void) configureNavigationContolller
{
    UIBarButtonItem *searchForBlog = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(loadPosts)];
    self.navigationItem.rightBarButtonItem = searchForBlog;
    [self updateBlogTitle];
}

- (void) setupData
{
    self.blogMeta = [[TBLBlogMeta alloc] initWithUsername:@"epicbeta"];
    self.blogPosts = [NSMutableArray array];
    self.dataSource = [[TBLDataSource alloc] initWithBlog:self.blogMeta blogPosts:self.blogPosts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Data Source & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _blogPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBLPost *post = _blogPosts[indexPath.row];
    NSString *identifier = [TBLPostTypeMap stringForPostType:post.type];
    __weak TBLPostCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    //cell.tag = indexPath.row;
    if ([cell.reuseIdentifier isEqualToString:@"photo"])
    {
        __weak TBLPostPhoto * photoPost = (TBLPostPhoto *)post;
        __weak TBLPhotoCell * photoCell = (TBLPhotoCell *)cell;
        photoCell.photoView.image = nil;
        if (photoPost.photoURLsAreNotNil)
        {
            NSURL *URL = [NSURL URLWithString:photoPost.iPhoneOptimizedPhotoURL];
            
            
            [photoCell.photoView pin_setImageFromURL:URL placeholderImage:[UIImage imageNamed:@"placeholder"]];
            
        }
    }
    [cell propagateContentFromPost:post andBlogMeta:self.blogMeta];
    if ([self shouldFetchNewPostsForIndexPath:indexPath])
        [self loadPosts];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  250;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - Pull to Refresh

-(void) setupRefreshControl
{
    if (self.refreshControl == nil) {
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Przesuń w dół, żeby odświeżyć"];
        [self.refreshControl addTarget:self action:@selector(refreshPosts) forControlEvents:UIControlEventValueChanged];
    }
}

- (void) refreshPosts
{
    if (self.dataSource == nil && self.refreshControl != nil && self.refreshControl.refreshing == YES)
    {
        [self.refreshControl endRefreshing];
        return;
    }
    [self loadPosts];
}

- (void) updateLastTimeResreshed
{
    NSDate *lastTime = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterLongStyle;
    NSString *lastTimeString = [NSString stringWithFormat:@"Ostatnia aktualizacja: %@",[dateFormatter stringFromDate:lastTime]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastTimeString];
}


#pragma mark - Fetch Data

- (void) loadPosts
{
    if (self.dataSource == nil)
    {
        return;
    }
    
    self.isFetchingPosts = YES;
    [self.dataSource fetchPostsWithCompletionSuccess:^(NSURLSessionTask * _Nonnull task, TBLBlogMeta * _Nullable blog, NSArray<TBLPost *> * _Nullable posts, NSError * _Nullable error) {
        self.isFetchingPosts = NO;
        
        if (self.refreshControl != nil && self.refreshControl.refreshing == YES)
            [self.refreshControl endRefreshing];

        self.blogMeta.startPostIndex = blog.startPostIndex;
        self.blogMeta.totalPostsCount = blog.totalPostsCount;
        
        [self.blogPosts addObjectsFromArray:posts];
        [self.tableView reloadData];
        [self updateBlogTitle];
        NSLog(@"FETCH: FINAL SUCCESS");
        if (posts.count == 0)
            NSLog(@"RESPONSE: NO MORE POSTS TO LOAD");
        
        [self updateLastTimeResreshed];
        
    } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"FETCH ERROR : %@", error);
        self.isFetchingPosts = NO;
    }];
    
}

/*
- (void) loadMorePosts
{
    self.isFetchingPosts = YES;
    [self activityIndicatorEnabled:YES];
    [self.dataSource fetchPostsWithCompletionSuccess:^(NSURLSessionTask * _Nonnull task, TBLBlogMeta * _Nullable blog, NSArray<TBLPost *> * _Nullable posts, NSError * _Nullable error) {
        self.isFetchingPosts = NO;
        self.blogMeta.startPostIndex = blog.startPostIndex;
        self.blogMeta.totalPostsCount = blog.totalPostsCount;
        [self.tableView beginUpdates];
        
        NSLog(@"!!!!!!!!! MODEL");
        NSLog(@"self.blogPosts before: %li",[self.blogPosts count]);
        [self.blogPosts addObjectsFromArray:posts];
        int row = (int)[self.blogPosts count];
        NSLog(@"self.blogPosts after: %li",[self.blogPosts count]);
        NSLog(@"!!!!!!!!! TABLE");
        NSLog(@"self.tableView calculation (= before): %i",row);
        [self updateBlogTitle];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];

        NSLog(@"FETCH: FINAL SUCCESS");
        for (TBLPost *post in posts) {
            NSLog(@"Loaded post with type: %@, dated: %@", [TBLPostTypeMap stringForPostType:post.type],post.date);
            self.isFetchingPosts = NO;
        }
        if (posts.count == 0)
            NSLog(@"RESPONSE: NO MORE POSTS TO LOAD");
        [self activityIndicatorEnabled:NO];
        
    } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"FETCH ERROR : %@", error);
        [self activityIndicatorEnabled:NO];
    }];
    
}
*/
- (void) activityIndicatorEnabled:(BOOL)active
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = active;
    
}

- (BOOL) shouldFetchNewPostsForIndexPath:(NSIndexPath *)indexPath
{
    long rowsLoaded = (long)[self.blogPosts count];
    long rowsRemaining = rowsLoaded - (long)indexPath.row;
    long rowsToLoadFromBottom = 5;
    
    return (rowsRemaining <= rowsToLoadFromBottom);
    
}


@end
