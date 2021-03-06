//
//  ROSelectorView.h
//  Pods
//
//  Created by Heather Snepenger on 4/14/15.
//
//

#import <UIKit/UIKit.h>

@protocol ROSelectorDelegate <NSObject>

- (void)cancelButtonPressed;
- (void)confirmButtonPressed;
- (void)itemSelectedWithValue:(id)value;

@end

@interface ROSelectorView : UIView

+ (instancetype)newWithDisplayValues:(NSArray *)values andCancelButton:(NSString *) cancelTitle andConfirmButton:(NSString *)confirmTitle;
+ (instancetype)newWithDisplayValues:(NSArray *)values andTitle:(NSString *)title andCancelButton:(NSString *) cancelTitle andConfirmButton:(NSString *)confirmTitle;

@property (strong, nonatomic) id<ROSelectorDelegate> delegate;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *separatorColor;
@property (strong, nonatomic) NSArray *values;
@property (strong, nonatomic) UILabel *titleLabel;

- (void)setModalColor:(UIColor *)color;
- (void)setTableViewColor:(UIColor *)color;

@end
