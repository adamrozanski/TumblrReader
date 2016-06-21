//
//  TBLPost.m
//  TUMBL_Testy
//
//  Created by Adam on 10.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"

@implementation TBLPost

+ (TBLPostType)postTypeForJSONPost:(NSDictionary * _Nonnull)JSONPost {
    NSString *stringType = JSONPost[@"type"];
    return [[TBLPostTypeMap sharedInstance] postTypeForString:stringType];
}

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost {
    if ((self = [super init])) {
        NSString *type = JSONPost[@"type"];
        NSString *date = JSONPost[@"date"];
        
        if (!type || !date)
            return nil;
        
        self.postID = [JSONPost[@"id"] intValue];
        self.slug = JSONPost[@"slug"];
        self.type = [[TBLPostTypeMap sharedInstance] postTypeForString:type];
        self.tags = JSONPost[@"tags"];
        self.date = date;
        
    }
    return self;
}

- (nonnull NSString*)toHTML {
    return @"<html><body>TBLPost should be subclassed</body></html>";
}

- (nonnull NSString*)tagsAsString {
    return (self.tags) ? [self.tags componentsJoinedByString:@" "] : @"brak";
}

@end
