//
//  TBLQuoteCell.m
//  TUMBL
//
//  Created by Adam on 13.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLQuoteCell.h"

@implementation TBLQuoteCell 

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.webViewHeightAnchor.constant = 50;
    }
    return self;
}

@end
