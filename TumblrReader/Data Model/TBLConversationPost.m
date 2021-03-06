//
//  TBLConversationPost.m
//  TumblrReader
//
//  Created by Adam Różański on 11.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLConversationPost.h"
#import "TumblerJSONResponseConsts.h"

@implementation TBLConversationPost

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost
{
    if ((self = [super initWithJSONPost:JSONPost]))
    {
        NSString *conversationText = JSONPost[kTumblerJSONPostConversationText];
        if (!conversationText)
        {
            return nil;
        }
        self.conversationText = conversationText;
        self.conversationTitle = JSONPost[kTumblerJSONPostConversationTitle];
    }
    return self;
}

- (nonnull NSString *)toHTML
{
    return [NSString stringWithFormat:@"<html><meta name=\"viewport\" content=\"initial-scale=1.0\" /><body><p><h1>%@</h1></p><p><h2>%@</h2></p></body></html>", self.conversationTitle, self.conversationText];
}

@end