//
//  TBLLinkPost.m
//  TumblrReader
//
//  Created by Adam Różański on 11.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLLinkPost.h"

@implementation TBLLinkPost

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost
{
    if ((self = [super initWithJSONPost:JSONPost]))
    {
        NSString *linkText = JSONPost[@"link-text"];
        NSString *linkURL = JSONPost[@"link-url"];
        NSString *linkDescription = JSONPost[@"link-description"];

        if (!linkText || !linkURL || !linkDescription)
            return nil;

        self.linkText = linkText;
        self.linkURL = linkURL;
        self.linkDescription = linkDescription;
    }
    return self;
}

- (nonnull NSString *)toHTML
{
    return [NSString stringWithFormat:@"<html><meta name=\"viewport\" content=\"initial-scale=1.0\" /><body><h1><a href=\"%@\">%@</a></h1><h2>%@</h2></body></html>", self.linkText, self.linkURL, self.linkDescription];
}
@end