//
//  SampleJSONPosts.h
//  UTMobica
//
//  Created by Adam on 14.07.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLPost.h"
#import "TBLPhotoPost.h"
#import "TBLPhoto.h"

@interface SampleJSONPosts : NSObject

+ (NSDictionary *)postPhoto;

+ (NSMutableDictionary *)post;

+ (NSMutableDictionary *)photo;

@end
