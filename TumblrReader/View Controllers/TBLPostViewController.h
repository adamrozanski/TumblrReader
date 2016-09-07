//
//  TBLPostViewController.h
//  TumblrReader
//
//  Created by Adam Różański on 15.06.2016.
//  Copyright © 2016 Adam Różański. All rights reserved.
//

#import "TBLBlogMeta.h"
#import "TBLPost.h"
#import <UIKit/UIKit.h>

@interface TBLPostViewController : UIViewController

- (nullable instancetype)initWithBlogMeta:(nullable TBLBlogMeta *)blogMeta post:(nullable TBLPost *)post;

@end
