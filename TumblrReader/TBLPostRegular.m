//
//  TBLPostRegular.m
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostRegular.h"

@implementation TBLPostRegular
- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost
{
    if ((self = [super initWithJSONPost:JSONPost]))
    {
        NSString *HTMLBody = [JSONPost objectForKey:@"regular-body"];
        if (HTMLBody == nil)
            return nil;
        self.HTMLBody = HTMLBody;
        self.title = [JSONPost objectForKey:@"regular-title"];

    }
    return self;
}

- (nonnull NSString*)toHTMLArticle
{
    NSString *HTMLTitle = [NSString stringWithFormat:@"<h1><strong>%@</strong></h1>", self.title];
    return [NSString stringWithFormat:@"<html><body>%@%@</body></html>",HTMLTitle, self.HTMLBody];
}
@end

