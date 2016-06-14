//
//  TBRBlog.m
//  TUMBL_Testy
//
//  Created by Adam on 10.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLBlogMeta.h"

@implementation TBLBlogMeta


- (nonnull instancetype)initWithUsername:(NSString * _Nonnull)username
{
    if ((self = [super init]))
    {
        self.name = username;
        self.startPostIndex = 0;
    }
    return self;
}

- (nullable instancetype)initWithJSONResponse:(NSDictionary *)json
{
    if ((self = [super init]))
    {
        NSDictionary *tumblelogField = [json objectForKey:@"tumblelog"];
        self.name = [tumblelogField objectForKey:@"name"];
        self.title = [tumblelogField objectForKey:@"title"];
        
        NSString *startPostIndex = [json objectForKey:@"posts-start"];
        NSString *totalPostsCount = [json objectForKey:@"posts-total"];
        if (startPostIndex == nil || totalPostsCount == nil || self.name == nil || self.title == nil)
            return nil;
        self.startPostIndex = startPostIndex.intValue;
        self.totalPostsCount = totalPostsCount.intValue;;
    }
    return self;
}

@end
