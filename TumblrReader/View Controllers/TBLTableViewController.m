//
//  ViewController.m
//  TumblrReader
//
//  Created by Adam Różański on 14.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLPostViewController.h"
#import "TBLTableViewController.h"

static NSString *const kInitialBlogName = @"epicbeta";
static NSString *const kNavigationBarTitle = @"Tumblr Reader";
static NSInteger const kCellHeight = 270;

@interface TBLTableViewController () <UITableViewDelegate>

@property (nonatomic, strong, nullable) TBLTableViewDataSource *dataSource;

@end

@implementation TBLTableViewController

#pragma mark - Initial Section

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    [self addNavigationButtonItem];
    [self configureTableViewForBlogName:kInitialBlogName];
    [self updateBlogTitle];
    [self setupRefreshControl];
}

- (void)setupTableView
{
    UIColor *greyColor = [UIColor colorWithRed:0.21 green:0.24 blue:0.28 alpha:1.0];
    self.tableView.backgroundColor = greyColor;
    self.tableView.separatorColor = greyColor;
    [self.tableView registerClass:[TBLQuoteCell class] forCellReuseIdentifier:[[TBLPostTypeMap sharedInstance] stringForPostType:TBLPostTypeQuote]];
    [self.tableView registerClass:[TBLPhotoCell class] forCellReuseIdentifier:[[TBLPostTypeMap sharedInstance] stringForPostType:TBLPostTypePhoto]];
    [self.tableView registerClass:[TBLRegularCell class] forCellReuseIdentifier:[[TBLPostTypeMap sharedInstance] stringForPostType:TBLPostTypeRegular]];
    [self.tableView registerClass:[TBLAudioCell class] forCellReuseIdentifier:[[TBLPostTypeMap sharedInstance] stringForPostType:TBLPostTypeAudio]];
    [self.tableView registerClass:[TBLConversationCell class] forCellReuseIdentifier:[[TBLPostTypeMap sharedInstance] stringForPostType:TBLPostTypeConversation]];
    [self.tableView registerClass:[TBLLinkCell class] forCellReuseIdentifier:[[TBLPostTypeMap sharedInstance] stringForPostType:TBLPostTypeLink]];
}

- (void)updateBlogTitle
{
    self.title = self.dataSource.blogMeta ? self.dataSource.blogMeta.name : kNavigationBarTitle;
}

- (void)addNavigationButtonItem
{
    UIBarButtonItem *searchForBlog = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(userEnterBlogName)];
    self.navigationItem.rightBarButtonItem = searchForBlog;
}

- (void)configureTableViewForBlogName:(NSString *)blogName
{
    if ([blogName isEqualToString:self.dataSource.blogMeta.name])
    {
        return;
    }
    self.dataSource = [[TBLTableViewDataSource alloc] initWithBlogName:blogName];
    self.tableView.dataSource = self.dataSource;
    [self loadPosts];
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    TBLPost *post = self.dataSource.posts[indexPath.row];
    TBLPostViewController *postViewController = [[TBLPostViewController alloc] initWithBlogMeta:self.dataSource.blogMeta post:post];
    [self.navigationController pushViewController:postViewController animated:YES];
}

- (void)tableView:(nonnull UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([self.dataSource shouldFetchNewPostsForIndexPath:indexPath])
    {
        [self loadPosts];
    }
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (BOOL)tableView:(nonnull UITableView *)tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Pull to Refresh

- (void)setupRefreshControl
{
    if (self.refreshControl == nil)
    {
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Przesuń w dół, żeby odświeżyć"];
        [self.refreshControl addTarget:self action:@selector(refreshPosts) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)refreshPosts
{
    if (!self.dataSource || (self.refreshControl && self.refreshControl.refreshing))
    {
        [self.refreshControl endRefreshing];
        return;
    }
    [self loadPosts];
}

- (void)updateLastTimeRefreshed
{
    NSDate *lastTime = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterLongStyle;
    NSString *lastTimeString = [NSString stringWithFormat:@"Ostatnia aktualizacja: %@", [dateFormatter stringFromDate:lastTime]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastTimeString];
}

#pragma mark - Load Posts

- (void)loadPosts
{
    [self.dataSource loadPostsIntoTableView:self.tableView
        success:^() {
          if (self.refreshControl && self.refreshControl.refreshing)
          {
              [self.refreshControl endRefreshing];
          }
          [self updateBlogTitle];
          [self updateLastTimeRefreshed];
        }
        failure:^(NSString *_Nullable errorMessage) {
          self.dataSource = nil;
          [self updateBlogTitle];
          [self presentMessage:errorMessage title:@"Błąd"];
        }];
}

#pragma mark - Dialogs

- (void)presentMessage:(nonnull NSString *)message title:(nonnull NSString *)title
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self.parentViewController presentViewController:alert animated:YES completion:nil];
}

- (void)userEnterBlogName
{
    UITextField *__block searchTextField;
    UIAlertController *searchController = [UIAlertController alertControllerWithTitle:@"Hello User" message:@"Wprowadź nazwę bloga w serwisie Tumblr" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {

      if ([searchTextField.text isEqualToString:@""])
      {
          [self presentMessage:@"Nieprawidłowa nazwa bloga " title:@"Błąd"];
          return;
      }
      [self configureTableViewForBlogName:searchTextField.text];
    }];
    UIAlertAction *epicbeta = [UIAlertAction actionWithTitle:@"Użyj: epicbeta" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
      [self configureTableViewForBlogName:@"epicbeta"];
    }];
    UIAlertAction *travelgurus = [UIAlertAction actionWithTitle:@"Użyj: travelgurus" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
      [self configureTableViewForBlogName:@"travelgurus"];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Anuluj" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
    }];
    [searchController addAction:ok];
    [searchController addAction:cancel];
    [searchController addAction:travelgurus];
    [searchController addAction:epicbeta];
    [searchController addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
      searchTextField = textField;
      searchTextField.placeholder = @"Nazwa bloga";
    }];
    [self.parentViewController presentViewController:searchController animated:YES completion:nil];
}

@end
