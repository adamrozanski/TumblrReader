//
//  TBLPostPhoto.h
//  TUMBL
//
//  Created by Adam on 11.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPost.h"

@interface TBLPostPhoto : TBLPost

@property (nonnull) NSString *caption;
@property (nonnull) NSString *photo1280URL;
@property (nonnull) NSString *photo500URL;
@property int width;
@property int height;

- (nullable instancetype)initWithJSONPost:(NSDictionary * _Nonnull)JSONPost;
- (nonnull NSString*)toHTML;
- (nonnull NSString*)captionToHTML;

@end

