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
#import "TBLPostViewController.h"

@interface TBLTableViewController () <UITableViewDelegate,UITableViewDataSource>

// TODO: decouple datasource props & methods from view controller
@property TBLBlogMeta * _Nullable blogMeta;
@property NSMutableArray<TBLPost *> * _Nullable blogPosts;
@property TBLDataSource * _Nullable dataSource;
@property BOOL isFetchingPosts;

@end

@implementation TBLTableViewController

#pragma mark - Initial Section

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self configureNavigationContolller];
    [self configureViewControllerForBlogName:@"epicbeta"];
    [self loadPosts];
}

-(void) setupTableView {
    self.tableView.backgroundColor = [UIColor colorWithRed:0.21f green:0.24f blue:0.28f alpha:1.0f];
    self.tableView.separatorColor = [UIColor colorWithRed:0.21f green:0.24f blue:0.28f alpha:1.0f];
    [self.tableView registerClass:[TBLQuoteCell class] forCellReuseIdentifier:@"quote"];
    [self.tableView registerClass:[TBLPhotoCell class] forCellReuseIdentifier:@"photo"];
    [self.tableView registerClass:[TBLRegularCell class] forCellReuseIdentifier:@"regular"];
    [self.tableView registerClass:[TBLAudioCell class] forCellReuseIdentifier:@"audio"];
    [self.tableView registerClass:[TBLConversationCell class] forCellReuseIdentifier:@"conversation"];
    [self.tableView registerClass:[TBLLinkCell class] forCellReuseIdentifier:@"link"];
}

- (void) updateBlogTitle {
    self.title = (self.blogMeta == nil) ? @"Tumblr Reader" : self.blogMeta.name;
}

- (void) configureNavigationContolller {
    UIBarButtonItem *searchForBlog = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(userEnterBlogName)];
    self.navigationItem.rightBarButtonItem = searchForBlog;
    [self updateBlogTitle];
}

- (void) configureViewControllerForBlogName:(NSString*)blogName {
    self.blogMeta = [[TBLBlogMeta alloc] initWithBlogName:blogName];
    self.blogPosts = [NSMutableArray array];
    self.dataSource = [[TBLDataSource alloc] initWithBlog:self.blogMeta blogPosts:self.blogPosts];
    [self.tableView reloadData];
    [self setupRefreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TBLPost *post = [self.blogPosts objectAtIndex:indexPath.row];
    TBLPostViewController *postViewController = [[TBLPostViewController alloc] initWithBlogMeta:self.blogMeta post:post];
    [self.navigationController pushViewController:postViewController animated:YES];    
}

#pragma mark - Table View Data Source & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blogPosts.count;
}
// TODO: create datasource method: cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBLPost *post = self.blogPosts[indexPath.row];
    NSString *identifier = [TBLPostTypeMap stringForPostType:post.type];
    TBLPostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

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
    if ([self shouldFetchNewPostsForIndexPath:indexPath])
        [self loadPosts];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  270;
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

- (void) refreshPosts {
    if (!self.dataSource || (self.refreshControl && self.refreshControl.refreshing)) {
        [self.refreshControl endRefreshing];
        return;
    }
    [self loadPosts];
}

- (void) updateLastTimeRefreshed {
    NSDate *lastTime = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterLongStyle;
    NSString *lastTimeString = [NSString stringWithFormat:@"Ostatnia aktualizacja: %@",[dateFormatter stringFromDate:lastTime]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastTimeString];
}


#pragma mark - Fetch Data
// TODO: move to datasource class
- (void) loadPosts {
    if (!self.dataSource || self.isFetchingPosts)
        return;
    self.isFetchingPosts = YES;
    [self activityIndicatorEnabled:YES];
    [self.dataSource fetchPostsWithCompletionSuccess:^(NSURLSessionTask * _Nonnull task, TBLBlogMeta * _Nullable blog, NSArray<TBLPost *> * _Nullable posts, NSError * _Nullable error) {
        if (error) {
            self.isFetchingPosts = NO;
            [self activityIndicatorEnabled:NO];
            [self presentMessage:@"Nie można przetworzyć danych z blogu" title:@"Błąd"];
            return;
        }
        if ([self.blogPosts count] == 0 && [posts count] == 0) {
            self.isFetchingPosts = NO;
            [self activityIndicatorEnabled:NO];
            [self presentMessage:@"Nie ma takiego bloga w Tumblr " title:@"Bład"];
            return;
        }
        self.isFetchingPosts = NO;
        [self activityIndicatorEnabled:NO];
        if (self.refreshControl && self.refreshControl.refreshing)
            [self.refreshControl endRefreshing];
        self.blogMeta.startPostIndex = blog.startPostIndex;
        self.blogMeta.totalPostsCount = blog.totalPostsCount;
        [self.blogPosts addObjectsFromArray:posts];
        [self.tableView reloadData];
        [self updateBlogTitle];
        [self updateLastTimeRefreshed];
    } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
        self.isFetchingPosts = NO;
        [self activityIndicatorEnabled:NO];
        [self presentMessage:@"Brak połączenia z internetem" title:@"Błąd"];
        return;
    }];
}

- (void) activityIndicatorEnabled:(BOOL)active {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = active;
}
// TODO: move to datasource class
- (BOOL) shouldFetchNewPostsForIndexPath:(NSIndexPath *)indexPath {
    long rowsLoaded = (long)[self.blogPosts count];
    long rowsRemaining = rowsLoaded - (long)indexPath.row;
    long rowsToLoadFromBottom = 10;
    return (rowsRemaining <= rowsToLoadFromBottom);
}

#pragma mark - Dialogs

- (void) presentMessage:(NSString*)message title:(NSString*)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self.parentViewController presentViewController:alert animated:YES completion:nil];
}

- (void) userEnterBlogName {
    UITextField * __block searchTextField;
    UIAlertController *searchController = [UIAlertController alertControllerWithTitle:@"Hello Braintri" message:@"Wprowadź nazwę bloga w serwisie Tumblr" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([searchTextField.text isEqualToString:@""]) {
            [self presentMessage:@"Nieprawidłowa nazwa bloga " title:@"Bład"];
            return;
        }
        [self configureViewControllerForBlogName:searchTextField.text];
        [self loadPosts];
    }];
    UIAlertAction *epicbeta = [UIAlertAction actionWithTitle:@"Użyj: epicbeta" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self configureViewControllerForBlogName:@"epicbeta"];
        [self loadPosts];
    }];
    UIAlertAction *travelgurus = [UIAlertAction actionWithTitle:@"Użyj: travelgurus" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self configureViewControllerForBlogName:@"travelgurus"];
        [self loadPosts];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Anuluj" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [searchController addAction:ok];
    [searchController addAction:cancel];
    [searchController addAction:travelgurus];
    [searchController addAction:epicbeta];
    [searchController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        searchTextField = textField;
        searchTextField.placeholder = @"Nazwa bloga";
    }];
    [self.parentViewController presentViewController:searchController animated:YES completion:nil];
}

@end
