//
//  TBLPostConversation.m
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostConversation.h"

@implementation TBLPostConversation

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost
{
    if ((self = [super initWithJSONPost:JSONPost]))
    {

        NSString *conversationText = [JSONPost objectForKey:@"conversation-text"];
        if (conversationText == nil)
            return nil;
        self.conversationText = conversationText;
        self.conversationTitle = [JSONPost objectForKey:@"conversation-title"];
    }
    return self;
}

- (nonnull NSString*)toHTML
{
    return [NSString stringWithFormat:@"<html><body><h1>%@</h1><h2>%@</h2></body></html>",self.conversationTitle, self.conversationText];
}


@end