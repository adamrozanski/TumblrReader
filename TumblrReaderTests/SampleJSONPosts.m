//
//  SampleJSONPosts.m
//  UTMobica
//
//  Created by Adam on 14.07.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "SampleJSONPosts.h"
#import <Foundation/Foundation.h>

@implementation SampleJSONPosts

+ (NSData *)JSONDataResponse {

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

+ (NSDictionary *)JSONResponse {
  NSMutableDictionary *sampleResponse = [NSMutableDictionary dictionary];
  NSDictionary *tumblelog = [self tumblelog];
  NSDictionary *tumblelogEntry = @{ @"tumblelog" : tumblelog };
  NSDictionary *postsStartEntry = @{ @"posts-start" : @(0) };
  NSDictionary *postsTotalEntry = @{ @"posts-total" : @(200) };
  NSArray *posts = [self posts];
  NSDictionary *postsField = @{ @"posts" : posts };
  [sampleResponse addEntriesFromDictionary:tumblelogEntry];
  [sampleResponse addEntriesFromDictionary:postsStartEntry];
  [sampleResponse addEntriesFromDictionary:postsTotalEntry];
  [sampleResponse addEntriesFromDictionary:postsField];
  return [sampleResponse copy];
}

+ (NSDictionary *)tumblelog {
  NSMutableDictionary *tumblelog = [NSMutableDictionary dictionary];
  NSDictionary *name = @{ @"name" : @"xyzNameXyz" };
  NSDictionary *title = @{ @"title" : @"xyzTitleXyz" };
  [tumblelog addEntriesFromDictionary:name];
  [tumblelog addEntriesFromDictionary:title];
  return [tumblelog copy];
}

+ (NSArray *)posts {
  NSDictionary *post = [self postPhoto];
  return @[ post, post, post, post, post, post, post ];
}

+ (NSDictionary *)postPhoto {
  NSMutableDictionary *samplePostPhoto = [[self genericPost] mutableCopy];
  [samplePostPhoto addEntriesFromDictionary:[self photo]];
  NSArray *galleryPhotos =
      @[ [self galleryPhoto], [self galleryPhoto], [self galleryPhoto] ];
  NSDictionary *galleryField = @{ @"photos" : galleryPhotos };
  [samplePostPhoto addEntriesFromDictionary:galleryField];
  return [samplePostPhoto copy];
}

+ (NSDictionary *)genericPost {
  NSDictionary *typeField = @{ @"type" : @"photo" };
  NSDictionary *dateFiled = @{ @"date" : @"2016-09-23" };
  NSDictionary *slugField = @{ @"slug" : @"some-slug-some-slug" };
  NSArray *tags = @[ @"tag1", @"tag2", @"tag3" ];
  NSDictionary *tagsField = @{ @"tags" : tags };

  NSMutableDictionary *samplePost = [NSMutableDictionary dictionary];
  [samplePost addEntriesFromDictionary:typeField];
  [samplePost addEntriesFromDictionary:dateFiled];
  [samplePost addEntriesFromDictionary:slugField];
  [samplePost addEntriesFromDictionary:tagsField];
  return [samplePost copy];
}

+ (NSMutableDictionary *)photo {
  NSDictionary *captionField = @{ @"photo-caption" : @"some caption" };
  NSDictionary *photo1280URL = @{ @"photo-url-1280" : @"some photo-url-1280" };
  NSDictionary *photo500URL = @{ @"photo-url-500" : @"some photo-url-500" };
  NSDictionary *photo250URL = @{ @"photo-url-250" : @"some photo-url-250" };
  NSDictionary *width = @{ @"width" : @"1024" };
  NSDictionary *height = @{ @"height" : @"768" };

  NSMutableDictionary *samplePhoto = [NSMutableDictionary dictionary];
  [samplePhoto addEntriesFromDictionary:captionField];
  [samplePhoto addEntriesFromDictionary:photo1280URL];
  [samplePhoto addEntriesFromDictionary:photo500URL];
  [samplePhoto addEntriesFromDictionary:photo250URL];
  [samplePhoto addEntriesFromDictionary:width];
  [samplePhoto addEntriesFromDictionary:height];
  return [samplePhoto copy];
}

+ (NSMutableDictionary *)galleryPhoto {
  NSDictionary *captionField = @{ @"caption" : @"some caption" };
  NSDictionary *photo1280URL = @{ @"photo-url-1280" : @"some photo-url-1280" };
  NSDictionary *photo500URL = @{ @"photo-url-500" : @"some photo-url-500" };
  NSDictionary *photo250URL = @{ @"photo-url-250" : @"some photo-url-250" };
  NSDictionary *width = @{ @"width" : @"1024" };
  NSDictionary *height = @{ @"height" : @"768" };

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
