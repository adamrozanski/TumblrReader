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

- (void) setupData
{
    self.blogMeta = [[TBLBlogMeta alloc] initWithUsername:@"ekipa"];
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
    if ([cell isMemberOfClass: [TBLPhotoCell class]])
    {
        
        TBLPostPhoto * photoPost = (TBLPostPhoto *)post;
        TBLPhotoCell *photoCell = (TBLPhotoCell *)cell;
        //photoCell
        if (photoPost.photo1280URL != nil)
        {
            [self.dataSource imageFromURLString:photoPost.photo1280URL success:^(UIImage * _Nullable image)
             {
                 if (photoCell != nil && image != nil) {
                     photoCell.photoView.image = image;
                     [photoCell setNeedsLayout];
                 }
             }
                                        failure:^(NSError * _Nonnull error)
             {
                 NSLog(@"ERROR DOWNLOADING PHOTO");
             }];
        }
    }
    [cell propagateContentFromPost:post andBlogMeta:self.blogMeta];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  250;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}



#pragma mark - Fetch Data

- (void) loadPosts
{
    [self.dataSource fetchPostsWithCompletionSuccess:^(NSURLSessionTask * _Nonnull task, TBLBlogMeta * _Nullable blog, NSArray<TBLPost *> * _Nullable posts, NSError * _Nullable error) {
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
