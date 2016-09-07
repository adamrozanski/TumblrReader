//
//  TBRBlog.h
//  TumblrReader
//
//  Created by Adam Różański on 10.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBLBlogMeta : NSObject

@property (strong, nonatomic, nonnull) NSString *name;
@property (strong, nonatomic, nonnull) NSString *title;
@property (assign, nonatomic) NSUInteger startPostIndex;
@property (assign, nonatomic) NSUInteger totalPostsCount;

- (nonnull instancetype)initWithBlogName:(nonnull NSString *)blogName;

- (nullable instancetype)initWithJSONResponse:(nonnull NSDictionary *)json;

@end
