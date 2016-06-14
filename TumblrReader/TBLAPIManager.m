//
//  TBLServiceManager.m
//  TUMBL_Testy
//
//  Created by Adam on 10.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLAPIManager.h"
#import "AFNetworking.h"

@implementation TBLAPIManager


+ (nonnull TBLAPIManager *)sharedManager {
    static TBLAPIManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}


- (void) fetchPostsForUsername:(NSString * _Nonnull)username
                startPostIndex:(int)startPostIndex
                    postsCount:(int)postsCount
                       success:(void (^ _Nonnull)(NSURLSessionTask * _Nonnull task, TBLBlogMeta * _Nullable blogMeta, NSArray<TBLPost*> * _Nullable posts, NSError * _Nullable error))success
                       failure:(void (^ _Nonnull)(NSURLSessionTask * _Nullable task, NSError * _Nonnull error))failure
{
    NSString *queryString = [self queryStringForUsername:username startPostIndex:startPostIndex postsCount:postsCount];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:queryString
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *operation, id responseObject) {
             NSError *error = nil;
             NSData *JSONData = [self extractJSONDataFromTumblrAPIV1Response:responseObject];
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:&error];
             if (error != nil) {
                 success(operation, nil, nil, error);
             } else {
                 TBLBlogMeta *blog = [[TBLBlogMeta alloc] initWithJSONResponse:JSON];
                 NSArray<TBLPost*> *posts = [TBLPostFactory postsArrayFromJSONResponse:JSON];
                 success(operation, blog, posts, error);
             }
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failure(operation, error);
         }
     ];
}


- (NSString *) queryStringForUsername:(NSString*)username startPostIndex:(int)startIndex postsCount:(int)postsCount
{
    return [NSString stringWithFormat:@"http://%@.tumblr.com/api/read/json?start=%i&num=%i&type=regular", username, startIndex, postsCount];
}


- (NSData *) extractJSONDataFromTumblrAPIV1Response: (NSData *)data
{
    int varDeclarationLength = 21;
    int semicolonLength = 1;
    return [data subdataWithRange: NSMakeRange(varDeclarationLength, data.length - varDeclarationLength - semicolonLength)];
}

- (void) imageFromURLString:(NSString * _Nonnull)URLString
                    success:(void (^ _Nonnull)(UIImage * _Nullable image))success
                    failure:(void (^ _Nonnull)(NSError * _Nonnull error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URLString
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             UIImage *image = [UIImage imageWithData:responseObject];
             success(image);
         }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             failure(error);
         }
     ];
}

@end