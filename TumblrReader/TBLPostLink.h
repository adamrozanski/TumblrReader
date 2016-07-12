//
//  TBLPostLink.h
//  TumblrReader
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"

@interface TBLPostLink : TBLPost

@property(nonnull) NSString *linkText;
@property(nonnull) NSString *linkURL;
@property(nonnull) NSString *linkDescription;

- (nullable instancetype)initWithJSONPost:(NSDictionary *_Nonnull)JSONPost;

- (nonnull NSString *)toHTML;

@end
