//
//  TBLPost.h
//  TumblrReader
//
//  Created by Adam on 10.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLPostTypeMap.h"

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
