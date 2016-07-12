//
//  TBLPostConversation.m
//  TumblrReader
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostConversation.h"

@implementation TBLPostConversation

- (nullable instancetype)initWithJSONPost:(NSDictionary *_Nonnull)JSONPost {
    if ((self = [super initWithJSONPost:JSONPost])) {
        NSString *conversationText = JSONPost[@"conversation-text"];
        if (!conversationText)
            return nil;
        self.conversationText = conversationText;
        self.conversationTitle = JSONPost[@"conversation-title"];
    }
    return self;
}

- (nonnull NSString *)toHTML {
    return [NSString stringWithFormat:@"<html><meta name=\"viewport\" content=\"initial-scale=1.0\" /><body><p><h1>%@</h1></p><p><h2>%@</h2></p></body></html>", self.conversationTitle, self.conversationText];
}

@end