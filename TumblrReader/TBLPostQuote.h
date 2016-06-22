//
//  TBLPostQoute.h
//  TumblrReader
//
//  Created by Adam on 10.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLPost.h"

@interface TBLPostQuote : TBLPost

@property (nonnull) NSString *quoteText;
@property (nonnull) NSString *quoteSource;

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost;
- (nonnull NSString*)toHTML;
@end
