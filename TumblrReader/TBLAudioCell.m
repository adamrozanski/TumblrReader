//
//  TBLAudioCell.m
//  TumblrReader
//
//  Created by Adam on 14.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLAudioCell.h"

@implementation TBLAudioCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.webViewHeightConstraint.constant -= 30;
    }
    return self;
}

@end
