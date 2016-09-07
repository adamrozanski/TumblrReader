//
//  TBLConversationPost.h
//  TumblrReader
//
//  Created by Adam Różański on 11.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLPost.h"

@interface TBLConversationPost : TBLPost

@property (strong, nonatomic, nullable) NSString *conversationTitle;
@property (strong, nonatomic, nonnull) NSString *conversationText;

- (nullable instancetype)initWithJSONPost:(nonnull NSDictionary *)JSONPost;

- (nonnull NSString *)toHTML;

@end
