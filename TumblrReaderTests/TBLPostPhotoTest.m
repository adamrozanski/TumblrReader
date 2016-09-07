//
//  TBLPostPhotoTest.m
//  TumblrReader
//
//  Created by Adam Różański on 14.07.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "SampleJSONPosts.h"
#import "TBLPhoto.h"
#import "TBLPhotoPost.h"
#import <OCMock/OCMock.h>
#import <XCTest/XCTest.h>

@interface TBLPostPhotoTest : XCTestCase

@property (strong, nonatomic) NSDictionary *samplePostPhoto;

@end

@implementation TBLPostPhotoTest

- (void)setUp
{
    [super setUp];
    self.samplePostPhoto = [SampleJSONPosts postPhoto];
}

- (void)tearDown
{
    self.samplePostPhoto = nil;
    [super tearDown];
}

- (void)testThatItFailsToInitWithNilPost
{
    NSDictionary *JSONPostPhoto = nil;
    TBLPhotoPost *postPhoto =
        [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
    XCTAssertNil(postPhoto, @"Instance must be Nil after passing Nil to constructor");
}

- (void)testThatItFailsToInitWithEmptyPost
{
    NSDictionary *JSONPostPhoto = @{};
    TBLPhotoPost *postPhoto =
        [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
    XCTAssertNil(postPhoto, @"Instance must be Nil after passing Nil to constructor");
}

- (void)testThatItParsesPhoto
{
    NSDictionary *JSONPostPhoto = self.samplePostPhoto;
    TBLPhotoPost *postPhoto =
        [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
    XCTAssertNotNil(postPhoto.photo, @"Photo property must be initialized after init");
}

- (void)testThatItParsesPhotoGallery
{
    NSDictionary *JSONPostPhoto = self.samplePostPhoto;
    TBLPhotoPost *postPhoto =
        [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
    XCTAssertNotNil(postPhoto.photoGallery, @"Photo gallery must be initialized after init");
}

- (void)testThatItConvertsPostToHTML
{
    NSDictionary *JSONPostPhoto = self.samplePostPhoto;
    TBLPhotoPost *postPhoto =
        [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
    NSString *HTML = [postPhoto toHTML];
    XCTAssertNotNil(HTML, @"Photo gallery must be initialized after init");
}

- (void)testThatItConvertsCaptionToHTML
{
    NSDictionary *JSONPostPhoto = self.samplePostPhoto;
    TBLPhotoPost *postPhoto =
        [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
    NSString *HTML = [postPhoto captionToHTML];
    XCTAssertNotNil(HTML, @"Photo gallery must be initialized after init");
}

- (void)testThatItReturnsIPhoneOptimizedURL
{
    NSDictionary *JSONPostPhoto = self.samplePostPhoto;
    TBLPhotoPost *postPhoto = [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
    NSString *URL = [postPhoto iPhoneOptimizedPhotoURLString];
    XCTAssertNotNil(URL, @"Photo gallery must be initialized after init");
}

- (void)testThatItReturnsTrueWhenURLsAreNotNil
{
    NSDictionary *JSONPostPhoto = self.samplePostPhoto;
    TBLPhotoPost *postPhoto =
        [[TBLPhotoPost alloc] initWithJSONPost:JSONPostPhoto];
    XCTAssert([postPhoto photoURLsAreNotNil],
              @"Photo gallery must be initialized after init");
}

@end
