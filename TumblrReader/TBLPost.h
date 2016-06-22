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

@property TBLPostType type;   // TBLPostType == uint
@property (nonnull) NSString *slug;
@property (nonnull) NSString *date;
@property (nullable) NSArray<NSString *> *tags;

+ (TBLPostType)postTypeForJSONPost:(NSDictionary * _Nonnull)JSONPost;
- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost;
- (nonnull NSString*)toHTML;
- (nonnull NSString*)tagsAsString;

@end
