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

@property (strong, nonatomic) id<ROSelectorDelegate> delegate;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *separatorColor;
@property (strong, nonatomic) NSArray *values;

- (void)setModalColor:(UIColor *)color;

@end
