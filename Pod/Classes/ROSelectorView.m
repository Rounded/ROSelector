//
//  ROSelectorView.m
//  Pods
//
//  Created by Heather Snepenger on 4/14/15.
//
//

#import "ROSelectorView.h"
#import "PureLayout.h"
#import "ROSelectorTableViewCell.h"


@interface ROSelectorView() <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) NSString *cancelTitle;
@property (strong, nonatomic) NSString *confirmTitle;
@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *confirmButton;

@property (strong, nonatomic) UIView *horizontalSeparatorView;
@property (strong, nonatomic) UIView *verticalSeparatorView;

@property (strong, nonatomic) UIView *modalView;

@end

@implementation ROSelectorView

+ (instancetype)newWithDisplayValues:(NSArray *)values andCancelButton:(NSString *) cancelTitle andConfirmButton:(NSString *)confirmTitle {
    ROSelectorView *selectorView = [ROSelectorView newAutoLayoutView];
    selectorView.values = values;
    selectorView.cancelTitle = cancelTitle;
    selectorView.confirmTitle = confirmTitle;
    return selectorView;
}

+ (instancetype)newWithDisplayValues:(NSArray *)values andTitle:(NSString *)title andCancelButton:(NSString *) cancelTitle andConfirmButton:(NSString *)confirmTitle {
    ROSelectorView *selectorView = [ROSelectorView newAutoLayoutView];
    selectorView.values = values;
    selectorView.title = title;
    selectorView.cancelTitle = cancelTitle;
    selectorView.confirmTitle = confirmTitle;
    return selectorView;
}

- (id)init {
    self = [super init];
    
    if (self) {
        [self styleView];
        [self addAllSubviews];
    }
    return self;
}

- (void)styleView {
    self.backgroundColor = [UIColor colorWithRed:66.0f/255.0f
                                           green:79.0f/255.0f
                                            blue:91.0f/255.0f
                                           alpha:0.9f];
    
}

- (void) addAllSubviews {
    
    [self addSubview:self.modalView];
    [self.modalView addSubview:self.titleLabel];
    [self.modalView addSubview:self.tableView];
    [self.modalView addSubview:self.cancelButton];
    [self.modalView addSubview:self.confirmButton];
    
    [self.modalView addSubview:self.horizontalSeparatorView];
    [self.modalView addSubview:self.verticalSeparatorView];
}

- (void) layoutSubviews {
    
    [self.modalView autoCenterInSuperview];
    [self.modalView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(100, 50, 100, 50)];
    
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(40, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
    [self.titleLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.tableView withOffset:-10];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];

    
    [self.cancelButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView];
    [self.cancelButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.cancelButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.cancelButton autoSetDimension:ALDimensionHeight toSize:50];
    
    if (self.confirmTitle) {
        [self.cancelButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withMultiplier:0.5];

        [self.confirmButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView];
        [self.confirmButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        [self.confirmButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [self.confirmButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withMultiplier:0.5];
    } else {
//        [self.cancelButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withMultiplier:1];
    }
    
    
    [self.horizontalSeparatorView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [self.horizontalSeparatorView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    [self.horizontalSeparatorView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.cancelButton];
    
    [self.verticalSeparatorView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.verticalSeparatorView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.horizontalSeparatorView];
    [self.verticalSeparatorView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.cancelButton];
    
}

#pragma mark - TableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.values count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ROSelectorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = [self.values[indexPath.row] description];
    if (self.font) {
        cell.titleLabel.font = self.font;
    }
    NSLog(@"%@", [self.values[indexPath.row] description]);

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate) {
        [self.delegate itemSelectedWithValue:self.values[indexPath.row]];
    }
}


#pragma mark - Methods
- (void)cancelPressed {
    if ([self.delegate respondsToSelector:@selector(cancelButtonPressed)]) {
        [self.delegate cancelButtonPressed];
    }
}

- (void)confirmPressed {
    if ([self.delegate respondsToSelector:@selector(confirmButtonPressed)]) {
        [self.delegate confirmButtonPressed];
    }
}

#pragma mark - Getters
- (UIView *)modalView {
    if (!_modalView) {
        _modalView = [UIView newAutoLayoutView];
    }
    return _modalView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView newAutoLayoutView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ROSelectorTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.layer.borderColor = [UIColor whiteColor].CGColor;
        _tableView.layer.borderWidth = 1;
        _tableView.layer.cornerRadius = 2;
    }
    return _tableView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.text = self.title;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton newAutoLayoutView];
        [_cancelButton setTitle:self.cancelTitle forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton newAutoLayoutView];
        [_confirmButton setTitle:self.confirmTitle forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIView *)horizontalSeparatorView {
    if (!_horizontalSeparatorView) {
        _horizontalSeparatorView = [UIView newAutoLayoutView];
        _horizontalSeparatorView.backgroundColor = [UIColor grayColor];
        [_horizontalSeparatorView autoSetDimension:ALDimensionHeight toSize:1];
    }
    return _horizontalSeparatorView;
}

- (UIView *)verticalSeparatorView {
    if (!_verticalSeparatorView) {
        _verticalSeparatorView = [UIView newAutoLayoutView];
        _verticalSeparatorView.backgroundColor = [UIColor grayColor];
        [_verticalSeparatorView autoSetDimension:ALDimensionWidth toSize:1];
    }
    return _verticalSeparatorView;
}

#pragma mark - Setters
- (void)setValues:(NSArray *)values {
    _values = values;
    [self.tableView reloadData];
}

- (void)setCancelTitle:(NSString *)cancelTitle {
    _cancelTitle = cancelTitle;
    [_cancelButton setTitle:self.cancelTitle forState:UIControlStateNormal];
}

- (void)setConfirmTitle:(NSString *)confirmTitle {
    _confirmTitle = confirmTitle;
    [_confirmButton setTitle:self.confirmTitle forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [self.tableView reloadData];
    self.confirmButton.titleLabel.font = font;
    self.cancelButton.titleLabel.font = font;
    self.titleLabel.font = font;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    self.horizontalSeparatorView.backgroundColor = separatorColor;
    self.verticalSeparatorView.backgroundColor = separatorColor;
}

- (void)setModalColor:(UIColor *)color {
    self.modalView.backgroundColor = color;
}

- (void)setTableViewColor:(UIColor *)color {
    self.tableView.backgroundColor = color;
}

@end
