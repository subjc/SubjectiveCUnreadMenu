//
//  SCMenuViewController.m
//  SCUnreadMenu
//
//  Created by Sam Page on 16/03/14.
//  Copyright (c) 2014 Subjective-C. All rights reserved.
//

#import "SCMenuViewController.h"

@interface SCMenuViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation SCMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    menuLabel.text = NSLocalizedString(@"Menu", @"Menu title");
    menuLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    
    [menuLabel sizeToFit];
    menuLabel.frame = CGRectIntegral(CGRectMake(CGRectGetMidX(self.view.bounds) - CGRectGetMidX(menuLabel.bounds),
                                                CGRectGetMidY(self.view.bounds) - CGRectGetMidY(menuLabel.bounds),
                                                CGRectGetWidth(menuLabel.bounds),
                                                CGRectGetHeight(menuLabel.bounds)));
    
    [self.view addSubview:menuLabel];
    
    UILabel *tapToCloseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tapToCloseLabel.text = NSLocalizedString(@"Tap to close", @"Menu tap to close text");
    
    [tapToCloseLabel sizeToFit];
    tapToCloseLabel.frame = CGRectIntegral(CGRectMake(CGRectGetMidX(self.view.bounds) - CGRectGetMidX(tapToCloseLabel.bounds),
                                                      CGRectGetMaxY(menuLabel.frame),
                                                      CGRectGetWidth(tapToCloseLabel.bounds),
                                                      CGRectGetHeight(tapToCloseLabel.bounds)));
    
    [self.view addSubview:tapToCloseLabel];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)tapGestureRecognized:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
