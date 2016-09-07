//
//  TBLAudioPost.h
//  TumblrReader
//
//  Created by Adam Różański on 11.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLPost.h"

@interface TBLAudioPost : TBLPost

@property (strong, nonatomic, nonnull) NSString *artist;
@property (strong, nonatomic, nonnull) NSString *title;
@property (strong, nonatomic, nonnull) NSString *caption;
@property (strong, nonatomic, nonnull) NSString *playerEmbed;

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost;

- (nonnull NSString *)toHTML;

@end
