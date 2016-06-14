//
//  TBLPostCell.m
//  TUMBL
//
//  Created by Adam on 13.06.2016.
//  Copyright © 2016 Adam. All rights reserved.
//

#import "TBLPostCell.h"


@implementation TBLPostCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.contentView.backgroundColor = [UIColor colorWithRed:0.24f green:0.39f blue:0.62f alpha:1.0f];
       
        self.dateLabel = [[UILabel alloc] init];
        [self.dateLabel setTextColor:[UIColor colorWithRed:0.24f green:0.39f blue:0.62f alpha:1.0f]];
        [self.dateLabel setBackgroundColor:[UIColor whiteColor]];
        [self.dateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f]];
        [self.dateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.titleBox = [[UIView alloc] init];
        [self.titleBox setBackgroundColor:[UIColor whiteColor]];
        [self.titleBox setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.titleBox addSubview:self.dateLabel];
        [self.contentView addSubview:self.titleBox];
        
        // Constraints: (must be here in case of UITableViewCell subclass, not in layoutSubviews)
        
        //dateLabel
        NSLayoutConstraint *dateLabelLeading = [self.dateLabel.leadingAnchor constraintEqualToAnchor: [self.titleBox leadingAnchor] constant:16];
        NSLayoutConstraint *dateLabelTailing = [self.dateLabel.trailingAnchor constraintEqualToAnchor: [self.titleBox trailingAnchor]];
        NSLayoutConstraint *dateLabelLTop = [self.dateLabel.topAnchor constraintEqualToAnchor: [self.titleBox topAnchor]];
        NSLayoutConstraint *dateLabelHleight = [self.dateLabel.heightAnchor constraintEqualToAnchor: [self.titleBox heightAnchor]];
        NSArray *dateLabelConstraints = @[dateLabelLeading, dateLabelTailing, dateLabelLTop, dateLabelHleight];
        [NSLayoutConstraint activateConstraints:dateLabelConstraints];
        
        //titleBox
        NSLayoutConstraint *titleBoxLeading = [self.titleBox.leadingAnchor constraintEqualToAnchor: [self.contentView leadingAnchor]];
        NSLayoutConstraint *ttitleBoxTailing = [self.titleBox.trailingAnchor constraintEqualToAnchor: [self.contentView trailingAnchor]];
        NSLayoutConstraint *titleBoxTop = [self.titleBox.topAnchor constraintEqualToAnchor: [self.contentView topAnchor]];
        NSLayoutConstraint *titleBoxHeight = [self.titleBox.heightAnchor constraintEqualToConstant:40];
        NSArray *titleBoxConstraints = @[titleBoxLeading, ttitleBoxTailing, titleBoxTop, titleBoxHeight];
        [NSLayoutConstraint activateConstraints:titleBoxConstraints];
    }
    return self;
}

- (CGFloat)labelHeight:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size.height;
}

- (CGFloat)cellHeight;
{
    return 20.0f;//[self labelHeight:self.textLabel];
}

- (void) propageteContentFromPost:(TBLPost * _Nonnull)post andBlogMeta:(TBLBlogMeta * _Nonnull)blogMeta
{
    self.dateLabel.text = post.date;
    self.tagsLabel.text = [post.tags componentsJoinedByString:@" "];
}

@end
