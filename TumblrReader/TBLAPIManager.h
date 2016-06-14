//
//  TBLServiceManager.h
//  TUMBL_Testy
//
//  Created by Adam on 10.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TBLBlogMeta.h"
#import "TBLPost.h"
#import "TBLPostQuote.h"
#import "TBLPostPhoto.h"
#import "TBLPostLink.h"
#import "TBLPostConversation.h"
#import "TBLPostAudio.h"
#import "TBLPostRegular.h"
#import "TBLPostFactory.h"

@interface TBLAPIManager : NSObject

+ (nonnull TBLAPIManager *)sharedManager;
- (void) fetchPostsForUsername:(NSString * _Nonnull)username
                startPostIndex:(int)startPostIndex
                    postsCount:(int)postsCount
                       success:(void (^ _Nonnull)(NSURLSessionTask * _Nonnull task, TBLBlogMeta * _Nullable blogMeta, NSArray<TBLPost*> * _Nullable posts, NSError * _Nullable error))success
                       failure:(void (^ _Nonnull)(NSURLSessionTask * _Nullable task, NSError * _Nonnull error))failure;

- (void) imageFromURLString:(NSString * _Nonnull)URLString
                    success:(void (^ _Nonnull)(UIImage * _Nullable image))success
                    failure:(void (^ _Nonnull)(NSError * _Nonnull error))failure;

@end
