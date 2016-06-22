//
//  TBLPostAudio.h
//  TumblrReader
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"

@interface TBLPostAudio : TBLPost

@property (nonnull) NSString *artist;
@property (nonnull) NSString *title;
@property (nonnull) NSString *caption;
@property (nonnull) NSString *playerEmbed;

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost;
- (nonnull NSString*)toHTML;

@end
