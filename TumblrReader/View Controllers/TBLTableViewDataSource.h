//
//  TBLTableViewDataSource.h
//  TumblrReader
//
//  Created by Adam Różański on 11.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLAPIManager.h"
#import "TBLAudioCell.h"
#import "TBLBlogMeta.h"
#import "TBLConversationCell.h"
#import "TBLLinkCell.h"
#import "TBLPhotoCell.h"
#import "TBLPhotoPost.h"
#import "TBLPost.h"
#import "TBLPostTypeMap.h"
#import "TBLQuoteCell.h"
#import "TBLRegularCell.h"
#import "TBLTableViewDataSource.h"
#import <UIKit/UIKit.h>

@interface TBLTableViewDataSource : NSObject <UITableViewDataSource>

@property (assign, nonatomic) BOOL isFetchingPosts;
@property (strong, nonatomic, nullable) TBLBlogMeta *blogMeta;
@property (strong, nonatomic, nullable) NSMutableArray<TBLPost *> *posts;

- (nullable instancetype)initWithBlogName:(nonnull NSString *)blogName;

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView;

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

- (void)loadPostsIntoTableView:(nonnull UITableView *)tableView
                       success:(void (^_Nonnull)(NSString *_Nullable errorMessage))success
                       failure:(void (^_Nonnull)(NSString *_Nonnull errorMessage))failure;

- (void)imageFromURLString:(nonnull NSString *)URLString
                   success:(void (^_Nonnull)(UIImage *_Nullable image))success
                   failure:(void (^_Nonnull)(NSError *_Nonnull error))failure;

- (BOOL)shouldFetchNewPostsForIndexPath:(nonnull NSIndexPath *)indexPath;
@end
