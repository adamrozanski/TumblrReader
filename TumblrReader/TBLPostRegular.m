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
        if (!HTMLBody)
            return nil;
        self.HTMLBody = HTMLBody;
        self.title = [JSONPost objectForKey:@"regular-title"];

    }
    return self;
}

- (nonnull NSString*)toHTML
{
    return [NSString stringWithFormat:@"<html><meta name=\"viewport\" content=\"initial-scale=1.0\" /><body><h1><strong>%@</strong></h1>%@</body></html>",self.title, self.HTMLBody];
}
@end

