//
//  SampleJSONPosts.m
//  UTMobica
//
//  Created by Adam on 14.07.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "SampleJSONPosts.h"

@implementation SampleJSONPosts

+ (NSDictionary *)postPhoto {
    NSMutableDictionary *samplePostPhoto = [self post];
    [samplePostPhoto addEntriesFromDictionary:[self photo]];
    NSArray *galleryPhotos = @[[self galleryPhoto], [self galleryPhoto], [self galleryPhoto]];
    NSDictionary *galleryField = @{@"photos" : galleryPhotos};
    [samplePostPhoto addEntriesFromDictionary:galleryField];
    return (NSDictionary *) samplePostPhoto;
}

+ (NSMutableDictionary *)post {
    NSDictionary *typeField = @{@"type" : @"photo"};
    NSDictionary *dateFiled = @{@"date" : @"2016-09-23"};
    NSDictionary *slugField = @{@"slug" : @"some-slug-some-slug"};
    NSArray *tags = @[@"tag1", @"tag2", @"tag3"];
    NSDictionary *tagsField = @{@"tags" : tags};

    NSMutableDictionary *samplePost = [NSMutableDictionary dictionary];
    [samplePost addEntriesFromDictionary:typeField];
    [samplePost addEntriesFromDictionary:dateFiled];
    [samplePost addEntriesFromDictionary:slugField];
    [samplePost addEntriesFromDictionary:tagsField];
    return samplePost;
}

+ (NSMutableDictionary *)photo {
    NSDictionary *captionField = @{@"photo-caption" : @"some caption"};
    NSDictionary *photo1280URL = @{@"photo-url-1280" : @"some photo-url-1280"};
    NSDictionary *photo500URL = @{@"photo-url-500" : @"some photo-url-500"};
    NSDictionary *photo250URL = @{@"photo-url-250" : @"some photo-url-250"};
    NSDictionary *width = @{@"width" : @"1024"};
    NSDictionary *height = @{@"height" : @"768"};

    NSMutableDictionary *samplePhoto = [NSMutableDictionary dictionary];
    [samplePhoto addEntriesFromDictionary:captionField];
    [samplePhoto addEntriesFromDictionary:photo1280URL];
    [samplePhoto addEntriesFromDictionary:photo500URL];
    [samplePhoto addEntriesFromDictionary:photo250URL];
    [samplePhoto addEntriesFromDictionary:width];
    [samplePhoto addEntriesFromDictionary:height];
    return samplePhoto;
}

+ (NSMutableDictionary *)galleryPhoto {
    NSDictionary *captionField = @{@"caption" : @"some caption"};
    NSDictionary *photo1280URL = @{@"photo-url-1280" : @"some photo-url-1280"};
    NSDictionary *photo500URL = @{@"photo-url-500" : @"some photo-url-500"};
    NSDictionary *photo250URL = @{@"photo-url-250" : @"some photo-url-250"};
    NSDictionary *width = @{@"width" : @"1024"};
    NSDictionary *height = @{@"height" : @"768"};

    NSMutableDictionary *samplePhoto = [NSMutableDictionary dictionary];
    [samplePhoto addEntriesFromDictionary:captionField];
    [samplePhoto addEntriesFromDictionary:photo1280URL];
    [samplePhoto addEntriesFromDictionary:photo500URL];
    [samplePhoto addEntriesFromDictionary:photo250URL];
    [samplePhoto addEntriesFromDictionary:width];
    [samplePhoto addEntriesFromDictionary:height];
    return samplePhoto;
}

@end
