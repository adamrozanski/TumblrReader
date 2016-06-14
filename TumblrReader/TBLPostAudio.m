//
//  TBLPostAudio.m
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostAudio.h"

@implementation TBLPostAudio

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost
{
    if ((self = [super initWithJSONPost:JSONPost]))
    {
        
        NSString *artist = [JSONPost objectForKey:@"id3-artist"];
        NSString *title = [JSONPost objectForKey:@"id3-title"];
        NSString *caption = [JSONPost objectForKey:@"audio-caption"];
        NSString *HTMLEmbed = [JSONPost objectForKey:@"audio-embed"];
        
        if (artist == nil || title == nil || HTMLEmbed == nil || caption == nil)
            return nil;
        self.artist = artist;
        self.title = title;
        self.caption = caption;
        self.HTMLEmbed = HTMLEmbed;
    }
    return self;
}
@end