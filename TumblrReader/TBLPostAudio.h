//
//  TBLPostAudio.h
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"

@interface TBLPostAudio : TBLPost

@property (nonnull) NSString *artist;
@property (nonnull) NSString *title;
@property (nonnull) NSString *caption;
@property (nonnull) NSString *HTMLEmbed;

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost;

@end
