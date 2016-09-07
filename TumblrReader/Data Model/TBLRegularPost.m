//
//  TBLRegularPost.m
//  TumblrReader
//
//  Created by Adam Różański on 11.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLRegularPost.h"
#import "TumblerJSONResponseConsts.h"

@implementation TBLRegularPost

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost
{
    if ((self = [super initWithJSONPost:JSONPost]))
    {
        NSString *HTMLBody = JSONPost[kTumblerJSONPostRegularBody];
        if (!HTMLBody)
        {
            return nil;
        }
        self.HTMLBody = HTMLBody;
        self.title = JSONPost[kTumblerJSONPostRegularTitle];
    }
    return self;
}

- (nonnull NSString *)toHTML
{
    return [NSString stringWithFormat:@"<html><meta name=\"viewport\" content=\"initial-scale=1.0\" /><body><h1><strong>%@</strong></h1>%@</body></html>", self.title, self.HTMLBody];
}
@end
