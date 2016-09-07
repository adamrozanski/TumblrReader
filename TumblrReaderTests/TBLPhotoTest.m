//
//  TBLPhotoTest.m
//  TumblrReader
//
//  Created by Adam Różański on 14.07.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "SampleJSONPosts.h"
#import "TBLPhoto.h"
#import <XCTest/XCTest.h>

@interface TBLPhotoTest : XCTestCase

@property (strong, nonatomic) NSDictionary *samplePhoto;

@end

@implementation TBLPhotoTest

- (void)testThatItFailsToInitWithNilPhoto
{
    NSDictionary *JSONPhoto = nil;
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    XCTAssertNil(photo, @"Instance must be Nil after passing Nil to constructor");
}

- (void)testThatItFailsToInitWithEmptyPhoto
{
    NSDictionary *JSONPhoto = @{};
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    XCTAssertNil(photo, @"Instance must be Nil after passing empty argument to constructor");
}

- (void)testThatItParsesWidth
{
    NSDictionary *JSONPhoto = self.samplePhoto;
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    XCTAssert(photo.width > 0, @"Height must be set after init");
}

- (void)testThatItParsesHeight
{
    NSDictionary *JSONPhoto = self.samplePhoto;
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    XCTAssert(photo.height > 0, @"Width must be set after init");
}

- (void)testThatItParsesPhoto1280URL
{
    NSDictionary *JSONPhoto = self.samplePhoto;
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    XCTAssertNotNil(photo.photo1280URL, @"photo1280URL must be set after init");
}

- (void)testThatItParsesPhoto500URL
{
    NSDictionary *JSONPhoto = self.samplePhoto;
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    XCTAssertNotNil(photo.photo500URL, @"photo500URL must be set after init");
}

- (void)testThatItParsesPhoto250URL
{
    NSDictionary *JSONPhoto = self.samplePhoto;
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    XCTAssertNotNil(photo.photo250URL, @"photo250URL must be set after init");
}

- (void)testThatItConvertsPhotoToHTML
{
    NSDictionary *JSONPhoto = self.samplePhoto;
    TBLPhoto *postPhoto = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    NSString *HTML = [postPhoto toHTML];
    XCTAssertNotNil(HTML, @"Photo gallery must be initialized after init");
}

- (void)testThatItConvertsCaptionToHTML
{
    NSDictionary *JSONPhoto = self.samplePhoto;
    TBLPhoto *postPhoto = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    NSString *HTML = [postPhoto captionToHTML];
    XCTAssertNotNil(HTML, @"Photo gallery must be initialized after init");
}

- (void)testThatItReturnsIPhoneOptimizedURL
{
    NSDictionary *JSONPhoto = self.samplePhoto;
    TBLPhoto *postPhoto = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    NSString *URL = [postPhoto iPhoneOptimizedPhotoURLString];
    XCTAssertNotNil(URL, @"Photo gallery must be initialized after init");
}

- (void)testThatItURLsAreNotNil
{
    NSDictionary *JSONPhoto = self.samplePhoto;
    TBLPhoto *postPhoto = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    XCTAssert([postPhoto photoURLsAreNotNil], @"Photo gallery must be initialized after init");
}

@end
