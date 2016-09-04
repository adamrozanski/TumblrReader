//
//  TBLRegularPost.h
//  TumblrReader
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"

@interface TBLRegularPost : TBLPost

@property(strong, nonatomic, nullable) NSString *title;
@property(strong, nonatomic, nonnull) NSString *HTMLBody;

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost;

- (nonnull NSString *)toHTML;

@end

