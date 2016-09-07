//
//  SampleJSONPosts.m
//  TumblrReader
//
//  Created by Adam Różański on 14.07.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "SampleJSONPosts.h"
#import "TumblerJSONResponseConsts.h"

@implementation SampleJSONPosts

+ (NSData *)JSONDataResponse
{

    NSError *error;
    NSData *responseJSON =
        [NSJSONSerialization dataWithJSONObject:[self JSONResponse]
                                        options:NSJSONWritingPrettyPrinted
                                          error:&error];
    NSString *varString = @"var tumblr_api_read = ";
    NSData *varData = [varString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *colonString = @";";
    NSData *colonData = [colonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *responseJSONAsVar =
        [[NSMutableData alloc] initWithData:varData];
    [responseJSONAsVar appendData:responseJSON];
    [responseJSONAsVar appendData:colonData];
    return [responseJSONAsVar copy];
}

+ (NSDictionary *)JSONResponse
{
    NSMutableDictionary *sampleResponse = [NSMutableDictionary dictionary];
    NSDictionary *tumblelogEntry = @{kTumblerJSONTumblelog : [self tumblelog]};
    NSDictionary *postsStartEntry = @{ kTumblerJSONBlogStartPostIndex : @(0) };
    NSDictionary *postsTotalEntry = @{ kTumblerJSONBlogTotalPostsCount : @(200) };
    NSArray *posts = [self posts];
    NSDictionary *postsField = @{kTumblerJSONBlogPosts : posts};
    [sampleResponse addEntriesFromDictionary:tumblelogEntry];
    [sampleResponse addEntriesFromDictionary:postsStartEntry];
    [sampleResponse addEntriesFromDictionary:postsTotalEntry];
    [sampleResponse addEntriesFromDictionary:postsField];
    return [sampleResponse copy];
}

+ (NSDictionary *)tumblelog
{
    NSMutableDictionary *tumblelog = [NSMutableDictionary dictionary];
    NSDictionary *name = @{ kTumblerJSONTumblelogBlogName : @"xyzNameXyz" };
    NSDictionary *title = @{ kTumblerJSONTumblelogBlogTitle : @"xyzTitleXyz" };
    [tumblelog addEntriesFromDictionary:name];
    [tumblelog addEntriesFromDictionary:title];
    return [tumblelog copy];
}

+ (NSArray *)posts
{
    NSDictionary *post = [self postPhoto];
    return @[ post, post, post, post, post, post, post ];
}

+ (NSDictionary *)postPhoto
{
    NSMutableDictionary *samplePostPhoto = [[self genericPost] mutableCopy];
    [samplePostPhoto addEntriesFromDictionary:[self photo]];
    NSArray *galleryPhotos =
        @[ [self galleryPhoto], [self galleryPhoto], [self galleryPhoto] ];
    NSDictionary *galleryField = @{kTumblerJSONPostPhotoGallery : galleryPhotos};
    [samplePostPhoto addEntriesFromDictionary:galleryField];
    return [samplePostPhoto copy];
}

+ (NSDictionary *)genericPost
{
    NSDictionary *typeField = @{ kTumblerJSONPostType : @"photo" };
    NSDictionary *dateFiled = @{ kTumblerJSONPostDate : @"2016-09-23" };
    NSDictionary *slugField = @{ kTumblerJSONPostSlug : @"some-slug-some-slug" };
    NSDictionary *tagsField = @{ kTumblerJSONPostTags : @[ @"tag1", @"tag2", @"tag3" ] };

    NSMutableDictionary *samplePost = [NSMutableDictionary dictionary];
    [samplePost addEntriesFromDictionary:typeField];
    [samplePost addEntriesFromDictionary:dateFiled];
    [samplePost addEntriesFromDictionary:slugField];
    [samplePost addEntriesFromDictionary:tagsField];
    return [samplePost copy];
}

+ (NSDictionary *)photo
{
    NSDictionary *captionField = @{ kTumblerJSONPhotoCaption : @"some caption" };
    NSDictionary *photo1280URL = @{ kTumblerJSONPhotoURL1280 : @"some photo-url-1280" };
    NSDictionary *photo500URL = @{ kTumblerJSONPhotoURL500 : @"some photo-url-500" };
    NSDictionary *photo250URL = @{ kTumblerJSONPhotoURL250 : @"some photo-url-250" };
    NSDictionary *width = @{ kTumblerJSONPhotoWidth : @"1024" };
    NSDictionary *height = @{ kTumblerJSONPhotoHeight : @"768" };

    NSMutableDictionary *samplePhoto = [NSMutableDictionary dictionary];
    [samplePhoto addEntriesFromDictionary:captionField];
    [samplePhoto addEntriesFromDictionary:photo1280URL];
    [samplePhoto addEntriesFromDictionary:photo500URL];
    [samplePhoto addEntriesFromDictionary:photo250URL];
    [samplePhoto addEntriesFromDictionary:width];
    [samplePhoto addEntriesFromDictionary:height];
    return [samplePhoto copy];
}

+ (NSDictionary *)galleryPhoto
{
    NSDictionary *captionField = @{ kTumblerJSONPostMainPhotoCaption : @"some caption" };
    NSDictionary *photo1280URL = @{ kTumblerJSONPhotoURL1280 : @"some photo-url-1280" };
    NSDictionary *photo500URL = @{ kTumblerJSONPhotoURL500 : @"some photo-url-500" };
    NSDictionary *photo250URL = @{ kTumblerJSONPhotoURL250 : @"some photo-url-250" };
    NSDictionary *width = @{ kTumblerJSONPhotoWidth : @"1024" };
    NSDictionary *height = @{ kTumblerJSONPhotoHeight : @"768" };

    NSMutableDictionary *samplePhoto = [NSMutableDictionary dictionary];
    [samplePhoto addEntriesFromDictionary:captionField];
    [samplePhoto addEntriesFromDictionary:photo1280URL];
    [samplePhoto addEntriesFromDictionary:photo500URL];
    [samplePhoto addEntriesFromDictionary:photo250URL];
    [samplePhoto addEntriesFromDictionary:width];
    [samplePhoto addEntriesFromDictionary:height];
    return [samplePhoto copy];
}

@end
