//
//  TBLPostQoute.h
//  TumblrReader
//
//  Created by Adam Różański on 10.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLPost.h"
#import <Foundation/Foundation.h>

@interface TBLQuotePost : TBLPost

@property (strong, nonatomic, nonnull) NSString *quoteText;
@property (strong, nonatomic, nonnull) NSString *quoteSource;

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost;

- (nonnull NSString *)toHTML;
@end
