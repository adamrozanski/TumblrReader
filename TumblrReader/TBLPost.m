//
//  TBLPost.m
//  TUMBL_Testy
//
//  Created by Adam on 10.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"

@implementation TBLPost

+ (TBLPostType)postTypeForJSONPost:(NSDictionary * _Nonnull)JSONPost
{
    NSString *stringType = [JSONPost objectForKey:@"type"];
    return [TBLPostTypeMap postTypeForString:stringType];
}

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost
{
    if ((self = [super init]))
    {
        NSString *type = [JSONPost objectForKey:@"type"];
        NSString *date = [JSONPost objectForKey:@"date"];
        
        if (!type || !date)
            return nil;
        
        self.postID = [[JSONPost objectForKey:@"id"] intValue];
        self.slug = [JSONPost objectForKey:@"slug"];
        self.type = [TBLPostTypeMap postTypeForString:type];
        self.tags = [JSONPost objectForKey:@"tags"];
        self.date = date;
        
    }
    return self;
}

- (nonnull NSString*)toHTML
{
    return @"<html><body>TBLPost should be subclassed</body></html>";
}

- (nonnull NSString*)tagsAsString
{
    return (self.tags) ? [self.tags componentsJoinedByString:@" "] : @"brak";
}

@end
