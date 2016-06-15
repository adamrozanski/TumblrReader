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
    [self setupTableView];
    [self setupRefreshControl];
    [self configureNavigationContolller];
    [self userEnterBlogName];
    
}

-(void) setupTableView
{
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.21f green:0.24f blue:0.28f alpha:1.0f];
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
    UIBarButtonItem *searchForBlog = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(userEnterBlogName)];
    self.navigationItem.rightBarButtonItem = searchForBlog;
    [self updateBlogTitle];
}

- (void) configureViewControllerForBlogName:(NSString*)blogName
{
    self.blogMeta = [[TBLBlogMeta alloc] initWithUsername:blogName];  //epicbeta
    self.blogPosts = [NSMutableArray array];
    self.dataSource = [[TBLDataSource alloc] initWithBlog:self.blogMeta blogPosts:self.blogPosts];
    [self.tableView reloadData];
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
    TBLPostCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:@"photo"])
    {
        __weak TBLPostPhoto * photoPost = (TBLPostPhoto *)post;
        __weak TBLPhotoCell * photoCell = (TBLPhotoCell *)cell;
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
    return  260;
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
    if (!self.dataSource || (self.refreshControl && self.refreshControl.refreshing))
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
    if (!self.dataSource)
        return;
    self.isFetchingPosts = YES;
    [self.dataSource fetchPostsWithCompletionSuccess:^(NSURLSessionTask * _Nonnull task, TBLBlogMeta * _Nullable blog, NSArray<TBLPost *> * _Nullable posts, NSError * _Nullable error) {
        if (error)
        {
            self.isFetchingPosts = NO;
            [self presentMessage:@"Nie można przetworzyć danych z Tumblr" title:@"Błąd"];
            return;
        }
        if ([self.blogPosts count] == 0 && [posts count] == 0)
        {
            self.isFetchingPosts = NO;
            [self presentMessage:@"Nie ma takiego bloga w Tumblr " title:@"Bład"];
            return;
        }
        self.isFetchingPosts = NO;
        if (self.refreshControl && self.refreshControl.refreshing)
            [self.refreshControl endRefreshing];
        self.blogMeta.startPostIndex = blog.startPostIndex;
        self.blogMeta.totalPostsCount = blog.totalPostsCount;
        [self.blogPosts addObjectsFromArray:posts];
        [self.tableView reloadData];
        [self updateBlogTitle];
        [self updateLastTimeResreshed];
    }
                                             failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
                                                 self.isFetchingPosts = NO;
                                                 [self presentMessage:@"Nie ma takiego bloga w Tumblr" title:@"Błędna nazwa"];
                                             }];
    
}

- (void) activityIndicatorEnabled:(BOOL)active
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = active;
}

- (BOOL) shouldFetchNewPostsForIndexPath:(NSIndexPath *)indexPath
{
    long rowsLoaded = (long)[self.blogPosts count];
    long rowsRemaining = rowsLoaded - (long)indexPath.row;
    long rowsToLoadFromBottom = 10;
    return (rowsRemaining <= rowsToLoadFromBottom);
}

#pragma mark - Dialogs

- (void) presentMessage:(NSString*)message title:(NSString*)title
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self.parentViewController presentViewController:alert animated:YES completion:nil];
}


- (void) userEnterBlogName
{
    UITextField * __block searchTextField;
    UIAlertController *searchController = [UIAlertController alertControllerWithTitle:@"Hello Braintri" message:@"Wprowadź nazwę bloga w serwisie Tumblr" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([searchTextField.text isEqualToString:@""])
        {
            [self presentMessage:@"Nieprawidłowa nazwa bloga " title:@"Bład"];
            return;
        }
        [self configureViewControllerForBlogName:searchTextField.text];
        [self loadPosts];
    }];
    UIAlertAction *starwars = [UIAlertAction actionWithTitle:@"Lub użyj: starwars" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self configureViewControllerForBlogName:@"starwars"];
        [self loadPosts];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Anuluj" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [searchController addAction:ok];
    [searchController addAction:cancel];
    [searchController addAction:starwars];
    [searchController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        searchTextField = textField;
        searchTextField.placeholder = @"Nazwa bloga";
    }];
    [self.parentViewController presentViewController:searchController animated:YES completion:nil];
}


@end
