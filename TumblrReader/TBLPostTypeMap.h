//
//  TBLPostTypeMap.h
//  TumblrReader
//
//  Created by Adam on 12.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, TBLPostType) {
    TBLPostTypeUndefined,
    TBLPostTypeQuote,
    TBLPostTypePhoto,
    TBLPostTypeLink,
    TBLPostTypeConversation,
    TBLPostTypeAudio,
    TBLPostTypeRegular
};


@interface TBLPostTypeMap : NSObject
+ (nonnull TBLPostTypeMap *)sharedInstance;

- (TBLPostType)postTypeForString:(NSString *_Nonnull)stringType;

- (nullable NSString *)stringForPostType:(TBLPostType)postType;

@end
