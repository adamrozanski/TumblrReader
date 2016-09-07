//
//  TBLBlogMetaTest.m
//  TumblrReader
//
//  Created by Adam Różański on 07/07/16.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "SampleJSONPosts.h"
#import "TBLBlogMeta.h"
#import <OCMock/OCMock.h>
#import <XCTest/XCTest.h>

@interface TBLBlogMetaTest : XCTestCase

@end

@implementation TBLBlogMetaTest

- (void)testThatItInitsWithBlogName
{
    TBLBlogMeta *blogMeta = [[TBLBlogMeta alloc] initWithBlogName:@"testName"];
    XCTAssertNotNil(blogMeta, "Blog Meta cannot be nil after initialization with name");
}

- (void)testThatItFailsToInitWithEmptyBlogName
{
    NSString *name = nil;
    TBLBlogMeta *blogMeta = [[TBLBlogMeta alloc] initWithBlogName:name];
    XCTAssertNil(blogMeta, "Blog Meta must be nil after initialization with nil name");
}

- (void)testThatItFailsToInitWithJSONBeingNil
{
    NSDictionary *JSON = nil;
    TBLBlogMeta *blogMeta = [[TBLBlogMeta alloc] initWithJSONResponse:JSON];
    XCTAssertNil(blogMeta, "Blog Meta must be nil after initialization with nil JSON");
}

- (void)testThatItInitsWithJSON
{
    NSDictionary *tumblelog = @{ @"name" : @"jakas nazwa",
                                 @"title" : @"jakis tytuł" };
    NSDictionary *JSONResponse = @{ @"tumblelog" : tumblelog,
                                    @"posts-start" : @"0",
                                    @"posts-total" : @"100" };

    TBLBlogMeta *blogMeta = [[TBLBlogMeta alloc] initWithJSONResponse:JSONResponse];
    XCTAssertNotNil(blogMeta, "Blog Meta must not be nil after initialization with proper JSON");
}

- (void)testThatItFailsWithJSONWithNoIndexes
{
    NSDictionary *tumblelog = @{ @"name" : @"jakas nazwa",
                                 @"title" : @"jakis tytuł" };
    NSDictionary *JSONResponse = @{ @"tumblelog" : tumblelog };
    TBLBlogMeta *blogMeta = [[TBLBlogMeta alloc] initWithJSONResponse:JSONResponse];
    XCTAssertNil(blogMeta, "Blog Meta must not be nil after initialization with proper JSON");
}

- (void)testThatItFailsWithJSONWithEmptyTumblelog
{
    NSDictionary *tumblelog = @{};
    NSDictionary *JSONResponse = @{ @"tumblelog" : tumblelog };
    TBLBlogMeta *blogMeta = [[TBLBlogMeta alloc] initWithJSONResponse:JSONResponse];
    XCTAssertNil(blogMeta, "Blog Meta must not be nil after initialization with proper JSON");
}

@end
