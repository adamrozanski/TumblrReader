//
//  TBLLinkPost.h
//  TumblrReader
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"

@interface TBLLinkPost : TBLPost

@property (strong, nonatomic, nonnull) NSString *linkText;
@property (strong, nonatomic, nonnull) NSString *linkURL;
@property (strong, nonatomic, nonnull) NSString *linkDescription;

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost;

- (nonnull NSString *)toHTML;

@end
