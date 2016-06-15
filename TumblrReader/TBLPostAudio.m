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
        NSString *playerEmbed = [JSONPost objectForKey:@"audio-embed"];
        
        if (!artist || !title || !playerEmbed || !caption)
            return nil;
        
        self.artist = artist;
        self.title = title;
        self.caption = caption;
        self.playerEmbed = playerEmbed;
    }
    return self;
}

- (nonnull NSString*)toHTML
{
    return [NSString stringWithFormat:@"<html><body><h1><strong>%@</strong></h1><h2>%@</h2>%@<p>%@</p></body></html>",self.title, self.artist, self.caption, self.playerEmbed];
}


@end