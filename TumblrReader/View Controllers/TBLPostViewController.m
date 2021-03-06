//
//  TBLPostViewController.m
//  TumblrReader
//
//  Created by Adam Różański on 15.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLPostViewController.h"
#import <WebKit/WebKit.h>

@interface TBLPostViewController ()

@property (strong, nonatomic, nullable) TBLPost *post;
@property (strong, nonatomic, nullable) TBLBlogMeta *blogMeta;
@property (strong, nonatomic, nonnull) WKWebView *webView;

@end

@implementation TBLPostViewController

- (nullable instancetype)initWithBlogMeta:(nullable TBLBlogMeta *)blogMeta post:(nullable TBLPost *)post
{
    self = [super init];
    if (self)
    {
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
    {
        [self loadContent];
    }
}

- (void)configureSubviews
{
    //webview bugfix
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.selectionGranularity = WKSelectionGranularityCharacter;

    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    [self.view addSubview:self.webView];
    [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.webView.scrollView.bounces = NO;

    NSLayoutConstraint *webViewLeadingAnchor = [self.webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    NSLayoutConstraint *webViewTrailingAnchor = [self.webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    NSLayoutConstraint *webViewTopAnchor = [self.webView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.topAnchor];
    NSLayoutConstraint *webViewBottomAnchor = [self.webView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.bottomAnchor];
    NSArray *webViewConstraints = @[ webViewLeadingAnchor, webViewTrailingAnchor, webViewTopAnchor, webViewBottomAnchor ];
    [NSLayoutConstraint activateConstraints:webViewConstraints];
}

- (void)loadContent
{
    [self.webView loadHTMLString:self.post.toHTML baseURL:nil];
    NSString *setTextSizeRule = [NSString stringWithFormat:@"addCSSRule('body', '-webkit-text-size-adjust: %d%%;')", 200];
    [self.webView evaluateJavaScript:setTextSizeRule completionHandler:nil];
}

@end
