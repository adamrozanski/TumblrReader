//
//  TBRBlog.h
//  TUMBL_Testy
//
//  Created by Adam on 10.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBLBlogMeta : NSObject

@property NSString* _Nonnull name;
@property NSString* _Nonnull title;
@property int startPostIndex;
@property int totalPostsCount;

- (nullable instancetype)initWithJSONResponse:(NSDictionary * _Nullable)json;
- (nonnull instancetype)initWithUsername:(NSString * _Nonnull)username;
    
@end
