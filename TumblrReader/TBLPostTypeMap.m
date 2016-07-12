//
//  TBLPostTypeMap.m
//  TumblrReader
//
//  Created by Adam on 12.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostTypeMap.h"

@interface TBLPostTypeMap ()

@property NSDictionary *postTypesDictionary;

@end

@implementation TBLPostTypeMap

+ (nonnull TBLPostTypeMap *)sharedInstance {
    static TBLPostTypeMap *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (nonnull instancetype)init {
    if ((self = [super init])) {
        self.postTypesDictionary = @{
                @"undefined" : @0,
                @"quote" : @1,
                @"photo" : @2,
                @"link" : @3,
                @"conversation" : @4,
                @"audio" : @5,
                @"regular" : @6
        };
    }
    return self;
}

- (TBLPostType)postTypeForString:(NSString *_Nonnull)stringType {
    return (TBLPostType) [[self.postTypesDictionary valueForKey:stringType] integerValue];
}

- (nullable NSString *)stringForPostType:(TBLPostType)postType {
    NSArray *allKeys = [self.postTypesDictionary allKeys];
    for (NSUInteger i = 0; i < [allKeys count]; ++i) {
        NSString *key = allKeys[i];
        NSString *value = self.postTypesDictionary[key];
        if ([value isEqual:@(postType)]) {
            return key;
        }
    }
    return nil;
}

@end
