//
//  TBLPostConversation.h
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"

@interface TBLPostConversation : TBLPost

@property (nullable) NSString *conversationTitle;
@property (nonnull) NSString *conversationText;

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost;
- (nonnull NSString*)toHTML;

@end
