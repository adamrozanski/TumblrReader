//
//  TBLPostPhotoTest.m
//  UnitTesty
//
//  Created by Adam on 14.07.2016.
//  Copyright © 2016 intern Adam Różański. All rights reserved.
//

#import "SampleJSONPosts.h"
#import "TBLPhoto.h"
#import "TBLPhotoPost.h"
#import <OCMock/OCMock.h>
#import <XCTest/XCTest.h>

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

- (void)testThatItFailsToInitWithNilPost {
  // given
  NSDictionary *JSONPostPhoto = nil;
  // when
  TBLPhotoPost *postPhoto =
      [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
  // then
  XCTAssertNil(postPhoto,
               @"Instance must be Nil after passing Nil to constructor");
}

- (void)testThatItFailsToInitWithEmptyPost {
  // given
  NSDictionary *JSONPostPhoto = @{};
  // when
  TBLPhotoPost *postPhoto =
      [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
  // then
  XCTAssertNil(postPhoto,
               @"Instance must be Nil after passing Nil to constructor");
}

- (void)testThatItParsesPhoto {
  // given
  NSDictionary *JSONPostPhoto = self.samplePostPhoto;
  // when
  TBLPhotoPost *postPhoto =
      [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
  // then
  XCTAssertNotNil(postPhoto.photo,
                  @"Photo property must be initialized after init");
}

- (void)testThatItParsesPhotoGallery {
  // given
  NSDictionary *JSONPostPhoto = self.samplePostPhoto;
  // when
  TBLPhotoPost *postPhoto =
      [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
  // then
  XCTAssertNotNil(postPhoto.photoGallery,
                  @"Photo gallery must be initialized after init");
}

- (void)testThatItConvertsPostToHTML {
  // given
  NSDictionary *JSONPostPhoto = self.samplePostPhoto;
  // when
  TBLPhotoPost *postPhoto =
      [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
  // then
  NSString *HTML = [postPhoto toHTML];
  XCTAssertNotNil(HTML, @"Photo gallery must be initialized after init");
}

- (void)testThatItConvertsCaptionToHTML {
  // given
  NSDictionary *JSONPostPhoto = self.samplePostPhoto;
  // when
  TBLPhotoPost *postPhoto =
      [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
  // then
  NSString *HTML = [postPhoto captionToHTML];
  XCTAssertNotNil(HTML, @"Photo gallery must be initialized after init");
}

- (void)testThatItReturnsIPhoneOptimizedURL {
  // given
  NSDictionary *JSONPostPhoto = self.samplePostPhoto;
  // when
  TBLPhotoPost *postPhoto =
      [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
  // then
  NSString *URL = [postPhoto iPhoneOptimizedPhotoURLString];
  XCTAssertNotNil(URL, @"Photo gallery must be initialized after init");
}

- (void)testThatItReturnsTrueWhenURLsAreNotNil {
  // given
  NSDictionary *JSONPostPhoto = self.samplePostPhoto;
  // when
  TBLPhotoPost *postPhoto =
      [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
  // then
  XCTAssert([postPhoto photoURLsAreNotNil],
            @"Photo gallery must be initialized after init");
}

@end
