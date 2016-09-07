//
//  TBLAPIManagerTests.m
//  TumblrReader
//
//  Created by Adam Różański on 23.07.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "AFNetworking.h"
#import "SampleJSONPosts.h"
#import "TBLAPIManager.h"
#import "TBLBlogMeta.h"
#import "TBLPost.h"
#import <OCMock/OCMock.h>
#import <XCTest/XCTest.h>

@interface TBLAPIManagerTests : XCTestCase

@end

@interface TBLAPIManager (Test)

@property AFHTTPSessionManager *sessionManager;

@end

@implementation TBLAPIManagerTests

- (void)testItFetchesPosts {

  TBLAPIManager *manager = [TBLAPIManager sharedManager];
  AFHTTPSessionManager *sessionManagerMock =
      OCMPartialMock(manager.sessionManager);

  OCMExpect([sessionManagerMock GET:OCMOCK_ANY
                         parameters:OCMOCK_ANY
                           progress:OCMOCK_ANY
                            success:OCMOCK_ANY
                            failure:OCMOCK_ANY])
      .andDo(^(NSInvocation *invocation) {
        void (^successBlock)(NSURLSessionDataTask *task, id responseObject);
        [invocation getArgument:&successBlock atIndex:5];
        NSData *responseJSONData = [SampleJSONPosts JSONDataResponse];
        NSURLSessionDataTask *responseTask =
            [[NSURLSessionDataTask alloc] init];
        successBlock(responseTask, responseJSONData);
      });

  [manager fetchPostsForUsername:@"epicbeta"
      startPostIndex:0
      postsCount:10
      success:^(NSURLSessionTask *_Nonnull task,
                TBLBlogMeta *_Nullable blogMeta,
                NSArray<TBLPost *> *_Nullable posts, NSError *_Nullable error) {
        if (error) {
          XCTFail(@"Error fetching posts.");
          return;
        }
        XCTAssertNotNil(posts);
        XCTAssertNotNil(blogMeta);
        BOOL isPostsCountMatch =
            [posts count] == [[SampleJSONPosts posts] count];
        XCTAssertTrue(isPostsCountMatch);

      }
      failure:^(NSURLSessionTask *_Nullable task, NSError *_Nonnull error) {
        XCTFail(@"Error fetching posts.");
        return;
      }];

  OCMVerify(sessionManagerMock);
}

@end
