//
//  TBLPostQoute.m
//  TumblrReader
//
//  Created by Adam Różański on 10.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//
#import "TBLQuotePost.h"
#import "TumblerJSONResponseConsts.h"

@implementation TBLQuotePost

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost
{
    if ((self = [super initWithJSONPost:JSONPost]))
    {
        NSString *quoteText = JSONPost[kTumblerJSONPostQuoteText];
        NSString *quoteSource = JSONPost[kTumblerJSONPostQuoteSource];
        if (!quoteText || !quoteSource)
        {
            return nil;
        }
        self.quoteText = quoteText;
        self.quoteSource = quoteSource;
    }
    return self;
}

- (nonnull NSString *)toHTML
{
    return [NSString stringWithFormat:@"<html><meta name=\"viewport\" content=\"initial-scale=1.0\" /><body><h1><strong>%@</strong></h1>%@</body></html>", self.quoteText, self.quoteSource];
}

@end
