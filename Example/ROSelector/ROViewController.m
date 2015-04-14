//
//  ROViewController.m
//  ROSelector
//
//  Created by Heather Snepenger on 04/14/2015.
//  Copyright (c) 2014 Heather Snepenger. All rights reserved.
//

#import "ROViewController.h"
#import "ROSelectorView.h"


@interface ROViewController () <ROSelectorDelegate>

@property (strong, nonatomic) ROSelectorView *selectorView;

@end

@implementation ROViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.selectorView = [ROSelectorView newWithDisplayValues:@[@"One", @"Two", @"Three", @"Four", @"Five"] andCancelButton:@"Cancel" andConfirmButton:@"Ok"];
    [self.view addSubview:self.selectorView];
    
    NSDictionary *viewsDictionary = @{@"selectorView":self.selectorView};
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[selectorView(500)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    NSArray *constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[selectorView(300)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    
    NSLayoutConstraint *xCenterConstraint = [NSLayoutConstraint constraintWithItem:self.selectorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:xCenterConstraint];
    
    NSLayoutConstraint *yCenterConstraint = [NSLayoutConstraint constraintWithItem:self.selectorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:yCenterConstraint];
    
    [self.selectorView addConstraints:constraint_H];
    [self.selectorView addConstraints:constraint_V];
    
    self.selectorView.delegate = self;
    self.selectorView.font = [UIFont fontWithName:@"American Typewriter" size:18];
}

- (void)itemSelectedWithValue:(NSString *)value {
    NSLog(@"%@", value);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
