//
//  ROSelectorTableViewCell.m
//  Pods
//
//  Created by Heather Snepenger on 4/14/15.
//
//

#import "ROSelectorTableViewCell.h"
#import "PureLayout.h"

@implementation ROSelectorTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self styleViews];
        [self addAllSubviews];
    }
    return self;
}

- (void)styleViews {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)addAllSubviews {
    
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [self.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

#pragma mark Getters
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end
