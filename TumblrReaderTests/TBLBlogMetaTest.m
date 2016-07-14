//
//  TBLBlogMetaTest.m
//  UnitTesty
//
//  Created by intern Adam Różański on 07/07/16.
//  Copyright © 2016 intern Adam Różański. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "TBLBlogMeta.h"
#import "SampleJSONPosts.h"

@interface TBLBlogMetaTest : XCTestCase

@end

@implementation TBLBlogMetaTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItInitsWithBlogName {
    TBLBlogMeta *blogMeta = [[TBLBlogMeta alloc] initWithBlogName:@"testName"];
    XCTAssertNotNil(blogMeta, "Blog Meta cannot be nil after initialization with name");
}

- (void)testItFailsToInitWithEmptyBlogName {
    // given
    NSString *name = nil;
    // when
    TBLBlogMeta *blogMeta = [[TBLBlogMeta alloc] initWithBlogName:name];
    // then
    XCTAssertNil(blogMeta, "Blog Meta must be nil after initialization with nil name");
}


- (void)testItFailsToInitWithJSONBeingNil {
    // given
    NSDictionary *JSON = nil;
    // when
    TBLBlogMeta *blogMeta = [[TBLBlogMeta alloc] initWithJSONResponse:JSON];
    // then
    XCTAssertNil(blogMeta, "Blog Meta must be nil after initialization with nil JSON");

}

- (void)testItInitsWithJSON {
    // given
    NSDictionary *tumblelog = @{@"name" : @"jakas nazwa",
            @"title" : @"jakis tytuł"};
    NSDictionary *JSONResponse = @{@"tumblelog" : tumblelog,
            @"posts-start" : @"0",
            @"posts-total" : @"100"};
    // when
    TBLBlogMeta *blogMeta = [[TBLBlogMeta alloc] initWithJSONResponse:JSONResponse];
    // then
    XCTAssertNotNil(blogMeta, "Blog Meta must not be nil after initialization with proper JSON");

}

- (void)testFailsWithJSONWithNoIndexes {
    // given
    NSDictionary *tumblelog = @{@"name" : @"jakas nazwa",
            @"title" : @"jakis tytuł"};
    NSDictionary *JSONResponse = @{@"tumblelog" : tumblelog};
    // when
    TBLBlogMeta *blogMeta = [[TBLBlogMeta alloc] initWithJSONResponse:JSONResponse];
    // then
    XCTAssertNil(blogMeta, "Blog Meta must not be nil after initialization with proper JSON");
}


- (void)testFailsWithJSONWithEmptyTumblelog {
    // given
    NSDictionary *tumblelog = @{};
    NSDictionary *JSONResponse = @{@"tumblelog" : tumblelog};
    // when
    TBLBlogMeta *blogMeta = [[TBLBlogMeta alloc] initWithJSONResponse:JSONResponse];
    // then
    XCTAssertNil(blogMeta, "Blog Meta must not be nil after initialization with proper JSON");
}

@end