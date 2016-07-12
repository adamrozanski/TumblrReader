//
//  TBRBlog.h
//  TumblrReader
//
//  Created by Adam on 10.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBLBlogMeta : NSObject

@property NSString *_Nonnull name;
@property NSString *_Nonnull title;
@property int startPostIndex;
@property int totalPostsCount;

- (nonnull instancetype)initWithBlogName:(NSString *_Nonnull)blogName;

- (nullable instancetype)initWithJSONResponse:(NSDictionary *_Nullable)json;

@end
