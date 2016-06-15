//
//  TBLPostViewController.m
//  TumblrReader
//
//  Created by Adam on 15.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostViewController.h"

#import <WebKit/WebKit.h>
#import "TBLPostQuote.h"
#import "TBLPostPhoto.h"
#import "TBLPostLink.h"
#import "TBLPostConversation.h"
#import "TBLPostAudio.h"
#import "TBLPostRegular.h"
#import "TBLPostTypeMap.h"

@interface TBLPostViewController ()

@property TBLPost *post;
@property TBLBlogMeta *blogMeta;
@property WKWebView *webView;

@end

@implementation TBLPostViewController

- (instancetype) initWithBlogMeta:(TBLBlogMeta *)blogMeta post:(TBLPost *)post
{
    self = [super init];
    if (self) {
        self.post = post;
        self.blogMeta = blogMeta;
        self.title = post.date;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureSubviews];
    if (self.post)
        [self loadContent];
}

- (void)configureSubviews
{
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *webViewLeadingAnchor = [self.webView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor];
    NSLayoutConstraint *webViewTrailingAnchor = [self.webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    NSLayoutConstraint *webViewTopAnchor = [self.webView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor]; //bottomAnchor
    NSLayoutConstraint *webViewBottomAnchor = [self.webView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.bottomAnchor];
    NSArray *webViewConstraints = @[webViewLeadingAnchor, webViewTrailingAnchor, webViewTopAnchor, webViewBottomAnchor];
    [NSLayoutConstraint activateConstraints:webViewConstraints];
}

- (void) loadContent
{
    
    [self.webView loadHTMLString:self.post.toHTML baseURL:nil];
    /*
    TBLPostType postType = self.post.type;
    switch (postType) {
        case Quote:
            return [[TBLPostQuote alloc] initWithJSONPost:JSONPost];
        case Photo:
            return [[TBLPostPhoto alloc] initWithJSONPost:JSONPost];
        case Link:
            return [[TBLPostLink alloc] initWithJSONPost:JSONPost];
        case Conversation:
            return [[TBLPostConversation alloc] initWithJSONPost:JSONPost];
        case Audio:
            return [[TBLPostAudio alloc] initWithJSONPost:JSONPost];
        case Regular:
            return [[TBLPostRegular alloc] initWithJSONPost:JSONPost];
        default:
            return nil;
    }
    */
}

@end
