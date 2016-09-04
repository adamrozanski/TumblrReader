//
//  TBLPostQoute.h
//  TumblrReader
//
//  Created by Adam on 10.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLPost.h"

@interface TBLQuotePost : TBLPost

@property(strong, nonatomic, nonnull) NSString *quoteText;
@property(strong, nonatomic, nonnull) NSString *quoteSource;

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost;

- (nonnull NSString *)toHTML;
@end
