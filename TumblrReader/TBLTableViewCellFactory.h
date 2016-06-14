//
//  TBLTableViewCellFactory.h
//  TUMBL
//
//  Created by Adam on 13.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBLBlogMeta.h"
#import "TBLPost.h"
#import "TBLPostQuote.h"
#import "TBLPostPhoto.h"
#import "TBLPostLink.h"
#import "TBLPostConversation.h"
#import "TBLPostAudio.h"
#import "TBLPostRegular.h"
#import "TBLPostTypeMap.h"



@interface TBLTableViewCellFactory : NSObject

+ (nonnull UITableViewCell *) createCellForPostType:(TBLPostType)postType;

@end
