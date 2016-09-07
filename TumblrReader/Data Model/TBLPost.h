//
//  TBLPost.h
//  TumblrReader
//
//  Created by Adam Różański on 10.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLPostTypeMap.h"
#import <Foundation/Foundation.h>

@interface TBLPost : NSObject

@property (assign, nonatomic) TBLPostType type;
@property (strong, nonatomic, nonnull) NSString *slug;
@property (strong, nonatomic, nonnull) NSString *date;
@property (strong, nonatomic, nullable) NSArray<NSString *> *tags;

+ (TBLPostType)postTypeForJSONPost:(nonnull NSDictionary *)JSONPost;

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost;

- (nonnull NSString *)toHTML;

- (nonnull NSString *)tagsAsString;

@end
