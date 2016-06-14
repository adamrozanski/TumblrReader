//
//  ViewController.m
//  TumblrReader
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLTableViewController.h"

@interface TBLTableViewController () <UITableViewDelegate,UITableViewDataSource>

@property TBLBlogMeta * _Nullable blogMeta;
@property NSMutableArray<TBLPost * > * _Nullable blogPosts;
@property TBLDataSource * _Nullable dataSource;

@end

@implementation TBLTableViewController

#pragma mark - Initial Section

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureTableView];
    [self setupData];
    [self loadPosts];
}

-(void) configureTableView
{
    //self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.estimatedRowHeight = 400.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.24f green:0.39f blue:0.62f alpha:1.0f];
    
    [self.tableView registerClass:[TBLQuoteCell class] forCellReuseIdentifier:@"quote"];
    [self.tableView registerClass:[TBLPhotoCell class] forCellReuseIdentifier:@"photo"];
    
    //self.tableView.delegate = self;
    //self.tableView.dataSource = self;
    
    //[self.view addSubview:self.tableView];
}

- (void) setupData
{
    self.blogMeta = [[TBLBlogMeta alloc] initWithUsername:@"demo"];
    self.blogPosts = [NSMutableArray array];
    self.dataSource = [[TBLDataSource alloc] initWithBlog:self.blogMeta blogPosts:self.blogPosts];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

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
    [cell propageteContentFromPost:post andBlogMeta:self.blogMeta];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  200;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - Fetch Data

- (void) loadPosts
{
    [_dataSource fetchPostsWithCompletionSuccess:^(NSURLSessionTask * _Nonnull task, TBLBlogMeta * _Nullable blog, NSArray<TBLPost *> * _Nullable posts, NSError * _Nullable error) {
        
        NSLog(@"~~ START INDEX: %i",blog.startPostIndex);
        self.blogMeta.startPostIndex = blog.startPostIndex;
        self.blogMeta.totalPostsCount = blog.totalPostsCount;

        [self.blogPosts addObjectsFromArray:posts];
        [self.tableView reloadData];
        NSLog(@"FETCH: FINAL SUCCESS");
        //[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        for (TBLPost *post in posts) {
            NSLog(@"Loaded post with type: %@, dated: %@", [TBLPostTypeMap stringForPostType:post.type],post.date);
            
        }
        if (posts.count == 0)
            NSLog(@"RESPONSE: NO MORE POSTS TO LOAD");
        
    } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"FETCH ERROR : %@", error);
    }];
    
}

@end
