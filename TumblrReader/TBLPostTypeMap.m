//
//  TBLPostTypeMap.m
//  TUMBL
//
//  Created by Adam on 12.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostTypeMap.h"

// TODO: use NSDictionary as singleton instead
static const int postTypesCount = 7;
static NSString *postTypeNames[7] = { @"undefined", @"quote", @"photo", @"link", @"conversation", @"audio", @"regular" };


@implementation TBLPostTypeMap

+ (TBLPostType)postTypeForString: (NSString  * _Nonnull )stringType; {
    for (TBLPostType type = Undefined; type < postTypesCount; type++) {
        if ([postTypeNames[type] isEqualToString:stringType])
            return type;
    }
    return Undefined;
}

+ (nullable NSString*)stringForPostType: (TBLPostType)postType {
    for (TBLPostType type = Undefined; type < postTypesCount; type++) {
        if (type == postType)
            return (type != Undefined) ? postTypeNames[type] : nil;
    }
    return nil;
}

@end
