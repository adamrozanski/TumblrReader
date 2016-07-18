//
//  TBLRegularPost.h
//  TumblrReader
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"

@interface TBLRegularPost : TBLPost

@property(nullable) NSString *title;
@property(nonnull) NSString *HTMLBody;

- (nullable instancetype)initWithJSONPost:(NSDictionary *_Nonnull)JSONPost;

- (nonnull NSString *)toHTML;

@end

