//
//  TBLPostViewController.h
//  TumblrReader
//
//  Created by Adam on 15.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBLPost.h"
#import "TBLBlogMeta.h"

@interface TBLPostViewController : UIViewController

- (instancetype) initWithBlogMeta:(TBLBlogMeta *)blogMeta post:(TBLPost *)post;

@end
