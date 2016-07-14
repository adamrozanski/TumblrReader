//
//  TBLPhotoTest.m
//  UTMobica
//
//  Created by Adam on 14.07.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBLPhoto.h"
#import "SampleJSONPosts.h"


@interface TBLPhotoTest : XCTestCase

@property(strong, nonatomic) NSDictionary *samplePhoto;

@end

@implementation TBLPhotoTest

- (void)setUp {
    [super setUp];
    self.samplePhoto = [SampleJSONPosts photo];
}

- (void)tearDown {
    self.samplePhoto = nil;
    [super tearDown];
}

- (void)testItFailsToInitWithNullPhoto {
    // given
    NSDictionary *JSONPhoto = nil;
    // when
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    // then
    XCTAssertNil(photo, @"Instance must be null after passing null to constructor");
}

- (void)testItFailsToInitWithEmptyPhoto {
    // given
    NSDictionary *JSONPhoto = @{};
    // when
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    // then
    XCTAssertNil(photo, @"Instance must be null after passing empty argument to constructor");
}

- (void)testItParsesWidth {
    // given
    NSDictionary *JSONPhoto = self.samplePhoto;
    // when
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    // then
    XCTAssert(photo.width > 0, @"Height must be set after init");
}

- (void)testItParsesHeight {
    // given
    NSDictionary *JSONPhoto = self.samplePhoto;
    // when
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    // then
    XCTAssert(photo.height > 0, @"Width must be set after init");
}

- (void)testItParsesPhoto1280URL {
    // given
    NSDictionary *JSONPhoto = self.samplePhoto;
    // when
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    // then
    XCTAssertNotNil(photo.photo1280URL, @"photo1280URL must be set after init");
}

- (void)testItParsesPhoto500URL {
    // given
    NSDictionary *JSONPhoto = self.samplePhoto;
    // when
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    // then
    XCTAssertNotNil(photo.photo500URL, @"photo500URL must be set after init");
}

- (void)testItParsesPhoto250URL {
    // given
    NSDictionary *JSONPhoto = self.samplePhoto;
    // when
    TBLPhoto *photo = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    // then
    XCTAssertNotNil(photo.photo250URL, @"photo250URL must be set after init");
}

- (void)testItConvertsPhotoToHTML {
    // given
    NSDictionary *JSONPhoto = self.samplePhoto;
    // when
    TBLPhoto *postPhoto = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    // then
    NSString *HTML = [postPhoto toHTML];
    XCTAssertNotNil(HTML, @"Photo gallery must be initialized after init");
}

- (void)testItConvertsCaptionToHTML {
    // given
    NSDictionary *JSONPhoto = self.samplePhoto;
    // when
    TBLPhoto *postPhoto = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    // then
    NSString *HTML = [postPhoto captionToHTML];
    XCTAssertNotNil(HTML, @"Photo gallery must be initialized after init");
}

- (void)testItReturnsIPhoneOptimizedURL {
    // given
    NSDictionary *JSONPhoto = self.samplePhoto;
    // when
    TBLPhoto *postPhoto = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    // then
    NSString *URL = [postPhoto iPhoneOptimizedPhotoURLString];
    XCTAssertNotNil(URL, @"Photo gallery must be initialized after init");
}

- (void)testItURLsAreNotNull {
    // given
    NSDictionary *JSONPhoto = self.samplePhoto;
    // when
    TBLPhoto *postPhoto = [[TBLPhoto alloc] initWithJSONPhoto:JSONPhoto];
    // then
    XCTAssert([postPhoto photoURLsAreNotNil], @"Photo gallery must be initialized after init");
}

@end
