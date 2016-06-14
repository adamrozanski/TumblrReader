//
//  TBLPostTypeMap.h
//  TUMBL
//
//  Created by Adam on 12.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef enum {
    Undefined,
    Quote,
    Photo,
    Link,
    Conversation,
    Audio,
    Regular
} TBLPostType;


@interface TBLPostTypeMap : NSObject

+ (TBLPostType)postTypeForString: (NSString  * _Nonnull )stringType;
+ (nullable NSString*)stringForPostType: (TBLPostType)intType;

@end
