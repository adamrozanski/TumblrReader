//
//  TBLTableViewDataSource.h
//  TumblrReader
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TBLAPIManager.h"
#import "TBLTableViewDataSource.h"
#import "TBLBlogMeta.h"
#import "TBLPost.h"
#import "TBLPhotoPost.h"
#import "TBLPostTypeMap.h"
#import "TBLQuoteCell.h"
#import "TBLPhotoCell.h"
#import "TBLRegularCell.h"
#import "TBLAudioCell.h"
#import "TBLConversationCell.h"
#import "TBLLinkCell.h"

@interface TBLTableViewDataSource : NSObject <UITableViewDataSource>

@property (assign, nonatomic) BOOL isFetchingPosts;
@property (strong, nonatomic, nullable) TBLBlogMeta *blogMeta;
@property (strong, nonatomic, nullable) NSMutableArray<TBLPost *> *posts;

- (nullable instancetype)initWithBlogName:(nonnull NSString *)blogName;

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView;

- (UITableViewCell *_Nonnull)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

- (void)loadPostsIntoTableView:(nonnull UITableView *)tableView
                       success:(void ( ^ _Nonnull)(NSString *_Nullable errorMessage))success
                       failure:(void (^ _Nonnull)(NSString *_Nonnull errorMessage))failure;

- (void)imageFromURLString:(nonnull NSString *)URLString
                   success:(void (^ _Nonnull)(UIImage *_Nullable image))success
                   failure:(void (^ _Nonnull)(NSError *_Nonnull error))failure;

- (BOOL)shouldFetchNewPostsForIndexPath:(nonnull NSIndexPath *)indexPath;
@end
