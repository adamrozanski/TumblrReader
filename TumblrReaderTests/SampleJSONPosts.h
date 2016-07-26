//
//  SampleJSONPosts.h
//  UTMobica
//
//  Created by Adam on 14.07.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPhoto.h"
#import "TBLPhotoPost.h"
#import "TBLPost.h"
#import <Foundation/Foundation.h>

@interface SampleJSONPosts : NSObject

+ (NSData *)JSONDataResponse;

+ (NSDictionary *)JSONResponse;

+ (NSDictionary *)tumblelog;

+ (NSArray *)posts;

+ (NSDictionary *)postPhoto;

+ (NSDictionary *)genericPost;

+ (NSDictionary *)photo;

@end
