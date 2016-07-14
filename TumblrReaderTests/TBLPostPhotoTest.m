//
//  TBLPostPhotoTest.m
//  UnitTesty
//
//  Created by Adam on 14.07.2016.
//  Copyright © 2016 intern Adam Różański. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "TBLPostPhoto.h"
#import "TBLPhoto.h"
#import "SampleJSONPosts.h"

@interface TBLPostPhotoTest : XCTestCase

@property(strong, nonatomic) NSDictionary *samplePostPhoto;

@end

@implementation TBLPostPhotoTest

- (void)setUp {
    [super setUp];
    self.samplePostPhoto = [SampleJSONPosts postPhoto];

}

- (void)tearDown {
    self.samplePostPhoto = nil;
    [super tearDown];
}

- (void)testItFailsToInitWithNullPost {
    // given
    NSDictionary *JSONPostPhoto = nil;
    // when
    TBLPostPhoto *postPhoto = [[TBLPostPhoto alloc] initWithJSONPost:JSONPostPhoto];
    // then
    XCTAssertNil(postPhoto, @"Instance must be null after passing null to constructor");
}

- (void)testItFailsToInitWithEmptyPost {
    // given
    NSDictionary *JSONPostPhoto = @{};
    // when
    TBLPostPhoto *postPhoto = [[TBLPostPhoto alloc] initWithJSONPost:JSONPostPhoto];
    // then
    XCTAssertNil(postPhoto, @"Instance must be null after passing null to constructor");
}

- (void)testItParsesPhoto {
    // given
    NSDictionary *JSONPostPhoto = self.samplePostPhoto;
    // when
    TBLPostPhoto *postPhoto = [[TBLPostPhoto alloc] initWithJSONPost:JSONPostPhoto];
    // then
    XCTAssertNotNil(postPhoto.photo, @"Photo property must be initialized after init");
}

- (void)testItParsesPhotoGallery {
    // given
    NSDictionary *JSONPostPhoto = self.samplePostPhoto;
    // when
    TBLPostPhoto *postPhoto = [[TBLPostPhoto alloc] initWithJSONPost:JSONPostPhoto];
    // then
    XCTAssertNotNil(postPhoto.photoGallery, @"Photo gallery must be initialized after init");
}

- (void)testItConvertsPostToHTML {
    // given
    NSDictionary *JSONPostPhoto = self.samplePostPhoto;
    // when
    TBLPostPhoto *postPhoto = [[TBLPostPhoto alloc] initWithJSONPost:JSONPostPhoto];
    // then
    NSString *HTML = [postPhoto toHTML];
    XCTAssertNotNil(HTML, @"Photo gallery must be initialized after init");
}

- (void)testItConvertsCaptionToHTML {
    // given
    NSDictionary *JSONPostPhoto = self.samplePostPhoto;
    // when
    TBLPostPhoto *postPhoto = [[TBLPostPhoto alloc] initWithJSONPost:JSONPostPhoto];
    // then
    NSString *HTML = [postPhoto captionToHTML];
    XCTAssertNotNil(HTML, @"Photo gallery must be initialized after init");
}

- (void)testItReturnsIPhoneOptimizedURL {
    // given
    NSDictionary *JSONPostPhoto = self.samplePostPhoto;
    // when
    TBLPostPhoto *postPhoto = [[TBLPostPhoto alloc] initWithJSONPost:JSONPostPhoto];
    // then
    NSString *URL = [postPhoto iPhoneOptimizedPhotoURLString];
    XCTAssertNotNil(URL, @"Photo gallery must be initialized after init");
}

- (void)testItURLsAreNotNull {
    // given
    NSDictionary *JSONPostPhoto = self.samplePostPhoto;
    // when
    TBLPostPhoto *postPhoto = [[TBLPostPhoto alloc] initWithJSONPost:JSONPostPhoto];
    // then
    XCTAssert([postPhoto photoURLsAreNotNil], @"Photo gallery must be initialized after init");
}

@end
