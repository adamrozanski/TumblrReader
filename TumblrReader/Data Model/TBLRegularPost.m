//
//  TBLRegularPost.m
//  TumblrReader
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLRegularPost.h"

@implementation TBLRegularPost

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost {
    if ((self = [super initWithJSONPost:JSONPost])) {
        NSString *HTMLBody = JSONPost[@"regular-body"];
        if (!HTMLBody)
            return nil;
        self.HTMLBody = HTMLBody;
        self.title = JSONPost[@"regular-title"];
    }
    return self;
}

- (nonnull NSString *)toHTML {
    return [NSString stringWithFormat:@"<html><meta name=\"viewport\" content=\"initial-scale=1.0\" /><body><h1><strong>%@</strong></h1>%@</body></html>", self.title, self.HTMLBody];
}
@end
