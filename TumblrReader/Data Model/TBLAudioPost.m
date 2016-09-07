//
//  TBLAudioPost.m
//  TumblrReader
//
//  Created by Adam Różański on 11.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLAudioPost.h"
#import "TumblerJSONResponseConsts.h"

@implementation TBLAudioPost

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost
{
    if ((self = [super initWithJSONPost:JSONPost]))
    {
        NSString *artist = JSONPost[kTumblerJSONPostAudioArtist];
        NSString *title = JSONPost[kTumblerJSONPostAudioTitle];
        NSString *caption = JSONPost[kTumblerJSONPostAudioCaption];
        NSString *playerEmbed = JSONPost[kTumblerJSONPostAudioEmbed];

        if (!artist || !title || !playerEmbed || !caption)
        {
            return nil;
        }

        self.artist = artist;
        self.title = title;
        self.caption = caption;
        self.playerEmbed = playerEmbed;
    }
    return self;
}

- (nonnull NSString *)toHTML
{
    return [NSString stringWithFormat:@"<html><meta name=\"viewport\" content=\"initial-scale=1.0\" /><body><h1><strong>%@</strong></h1><h2>%@</h2>%@<p>%@</p></body></html>", self.title, self.artist, self.caption, self.playerEmbed];
}

@end