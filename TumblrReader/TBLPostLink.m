//
//  TBLPostLink.m
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostLink.h"

@implementation TBLPostLink

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost
{
    if ((self = [super initWithJSONPost:JSONPost]))
    {
        NSString *linkText = [JSONPost objectForKey:@"link-text"];
        NSString *linkURL = [JSONPost objectForKey:@"link-url"];
        NSString *linkDescription = [JSONPost objectForKey:@"link-description"];
        
        if (linkText == nil || linkURL == nil || linkDescription == nil)
            return nil;
        
        self.linkText = linkText;
        self.linkURL = linkURL;
        self.linkDescription = linkDescription;
    }
    return self;
}
@end