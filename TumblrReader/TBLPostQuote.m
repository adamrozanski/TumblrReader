//
//  TBLPostQoute.m
//  TUMBL_Testy
//
//  Created by Adam on 10.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//
#import "TBLPostQuote.h"

@implementation TBLPostQuote


- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost
{
    if ((self = [super initWithJSONPost:JSONPost]))
    {
        NSString *quoteText = [JSONPost objectForKey:@"quote-text"];
        NSString *quoteSource = [JSONPost objectForKey:@"quote-source"];
        if (!quoteText || !quoteSource)
            return nil;
        self.quoteText = quoteText;
        self.quoteSource = quoteSource;
    }
    return self;
}

- (nonnull NSString*)toHTML
{
    return [NSString stringWithFormat:@"<html><body><h1><strong>%@</strong></h1>%@</body></html>",self.quoteText, self.quoteSource];
}

@end
