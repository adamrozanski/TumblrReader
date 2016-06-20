//
//  ViewController.m
//  TumblrReader
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLTableViewController.h"
#import "TBLPostViewController.h"

@interface TBLTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property TBLTableViewDataSource * _Nullable dataSource;

@end

@implementation TBLTableViewController

#pragma mark - Initial Section

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self configureNavigationController];
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
    self.title = (self.dataSource.blogMeta == nil) ? @"Tumblr Reader" : self.dataSource.blogMeta.name;
}

- (void) configureNavigationController {
    UIBarButtonItem *searchForBlog = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(userEnterBlogName)];
    self.navigationItem.rightBarButtonItem = searchForBlog;
    [self updateBlogTitle];
}

- (void) configureViewControllerForBlogName:(NSString*)blogName {
    self.dataSource = [[TBLTableViewDataSource alloc] initWithBlogName:blogName];
    [self.tableView reloadData];
    [self setupRefreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TBLPost *post = self.dataSource.blogPosts[(NSUInteger)indexPath.row];
    TBLPostViewController *postViewController = [[TBLPostViewController alloc] initWithBlogMeta:self.dataSource.blogMeta post:post];
    [self.navigationController pushViewController:postViewController animated:YES];    
}

#pragma mark - Table View Data Source & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource tableView:tableView numberOfRowsInSection:section];
}

// TODO: create datasource method: cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if ([self.dataSource shouldFetchNewPostsForIndexPath:indexPath])
        [self loadPosts];
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


#pragma mark - Load Posts

- (void) loadPosts {
    [self.dataSource loadPostsIntoTableView:self.tableView success:^(NSString * _Nullable errorMessage) {
        if (self.refreshControl && self.refreshControl.refreshing)
            [self.refreshControl endRefreshing];
        if (errorMessage) {
            [self presentMessage:errorMessage title:@"Błąd"];
            return;
        }
        [self updateBlogTitle];
        [self updateLastTimeRefreshed];
    } failure:^(NSString * _Nullable errorMessage) {
        [self presentMessage:errorMessage title:@"Błąd"];
    }];
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