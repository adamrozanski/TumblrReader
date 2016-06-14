//
//  TBLRegularCell.h
//  TUMBL
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "TBLPostCell.h"
#import "TBLPostRegular.h"
#import "TBLBlogMeta.h"

@interface TBLRegularCell : TBLPostCell

@property WKWebView * _Nullable articleWebView;

@end
