//
//  TBLTableViewDataSource.h
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TBLAPIManager.h"
#import "TBLTableViewDataSource.h"
#import "TBLBlogMeta.h"
#import "TBLPost.h"
#import "TBLPostPhoto.h"
#import "TBLPostTypeMap.h"
#import "TBLQuoteCell.h"
#import "TBLPhotoCell.h"
#import "TBLRegularCell.h"
#import "TBLAudioCell.h"
#import "TBLConversationCell.h"
#import "TBLLinkCell.h"

@interface TBLTableViewDataSource : NSObject <UITableViewDataSource>

@property BOOL isFetchingPosts;
@property TBLBlogMeta  * _Nullable blogMeta;
@property NSMutableArray<TBLPost *> * _Nullable posts;

- (nullable instancetype)initWithBlogName:(NSString * _Nonnull)blogName;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void) loadPostsIntoTableView:(UITableView * _Nonnull)tableView
                        success:(void (^ _Nonnull)(NSString * _Nullable errorMessage))success
                        failure:(void (^ _Nonnull)(NSString * _Nonnull errorMessage))failure;
- (void) imageFromURLString:(NSString * _Nonnull)URLString
                   success:(void (^ _Nonnull)(UIImage * _Nullable image))success
                   failure:(void (^ _Nonnull)(NSError * _Nonnull error))failure;
- (BOOL) shouldFetchNewPostsForIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end
