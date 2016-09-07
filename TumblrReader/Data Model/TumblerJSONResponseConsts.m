//
//  TumblerJSONResponseConsts.m
//  TumblrReader
//
//  Created by Adam Różański on 07.09.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TumblerJSONResponseConsts.h"

// Blog Meta
NSString *const kTumblerJSONBlogStartPostIndex = @"posts-start";
NSString *const kTumblerJSONBlogTotalPostsCount = @"posts-total";
NSString *const kTumblerJSONBlogPosts = @"posts";
NSString *const kTumblerJSONTumblelog = @"tumblelog";

// Tumblelog
NSString *const kTumblerJSONTumblelogBlogName = @"name";
NSString *const kTumblerJSONTumblelogBlogTitle = @"title";

// Any Post
NSString *const kTumblerJSONPostType = @"type";
NSString *const kTumblerJSONPostDate = @"date";
NSString *const kTumblerJSONPostSlug = @"slug";
NSString *const kTumblerJSONPostTags = @"tags";

// Photo Post
NSString *const kTumblerJSONPostMainPhotoCaption = @"caption";
NSString *const kTumblerJSONPostPhotoGallery = @"photos";

// Photo
NSString *const kTumblerJSONPhotoCaption = @"photo-caption";
NSString *const kTumblerJSONPhotoURL1280 = @"photo-url-1280";
NSString *const kTumblerJSONPhotoURL500 = @"photo-url-500";
NSString *const kTumblerJSONPhotoURL250 = @"photo-url-250";
NSString *const kTumblerJSONPhotoWidth = @"width";
NSString *const kTumblerJSONPhotoHeight = @"height";

// Link Post
NSString *const kTumblerJSONPostLinkText = @"link-text";
NSString *const kTumblerJSONPostLinkURL = @"link-url";
NSString *const kTumblerJSONPostLinkDescription = @"link-description";

// Conversation Post
NSString *const kTumblerJSONPostConversationTitle = @"conversation-title";
NSString *const kTumblerJSONPostConversationText = @"conversation-text";

// Audio Post
NSString *const kTumblerJSONPostAudioArtist = @"id3-artist";
NSString *const kTumblerJSONPostAudioTitle = @"id3-title";
NSString *const kTumblerJSONPostAudioCaption = @"audio-caption";
NSString *const kTumblerJSONPostAudioEmbed = @"audio-embed";

// Quote Post
NSString *const kTumblerJSONPostQuoteText = @"quote-text";
NSString *const kTumblerJSONPostQuoteSource = @"quote-source";

// Regular Post
NSString *const kTumblerJSONPostRegularBody = @"regular-body";
NSString *const kTumblerJSONPostRegularTitle = @"regular-title";
