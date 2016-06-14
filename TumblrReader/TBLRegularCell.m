//
//  TBLRegularCell.m
//  TUMBL
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLRegularCell.h"

@implementation TBLRegularCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.webViewHeightAnchor.constant += 10;
    }
    return self;
}


@end
