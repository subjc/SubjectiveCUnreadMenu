//
//  SCRootViewController.m
//  SCUnreadMenu
//
//  Created by Sam Page on 16/03/14.
//  Copyright (c) 2014 Subjective-C. All rights reserved.
//

#import "SCRootViewController.h"
#import "SCMenuViewController.h"
#import "SCOverlayPresentTransition.h"
#import "SCOverlayDismissTransition.h"
#import "SCDragAffordanceView.h"

@interface SCRootViewController () <UIScrollViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIScrollView *enclosingScrollView;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) SCMenuViewController *menuViewController;
@property (nonatomic, strong) SCDragAffordanceView *menuDragAffordanceView;

@end

@implementation SCRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menuViewController = [[SCMenuViewController alloc] initWithNibName:nil bundle:nil];
    self.menuViewController.transitioningDelegate = self;
    self.menuViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    self.enclosingScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.enclosingScrollView.alwaysBounceHorizontal = YES;
    self.enclosingScrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.enclosingScrollView.delegate = self;
    [self.view addSubview:self.enclosingScrollView];
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds textContainer:nil];
    self.textView.textContainerInset = UIEdgeInsetsMake(40.f, 20.f, 20.f, 20.f);
    self.textView.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.f];
    self.textView.textColor = [UIColor darkGrayColor];
    self.textView.editable = NO;
    [self.enclosingScrollView addSubview:self.textView];
    
    self.menuDragAffordanceView = [[SCDragAffordanceView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.enclosingScrollView.bounds) + 10.f, CGRectGetMidY(self.enclosingScrollView.bounds) - 25.f, 50.f, 50.f)];
    [self.enclosingScrollView addSubview:self.menuDragAffordanceView];
    
    NSString *contentPlistPath = [[NSBundle mainBundle] pathForResource:@"ArticleContent" ofType:@"plist"];
    NSDictionary *contentDictionary = [NSDictionary dictionaryWithContentsOfFile:contentPlistPath];
    self.textView.text = [contentDictionary valueForKey:@"body"];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDragging)
    {
        self.menuDragAffordanceView.progress = scrollView.contentOffset.x / CGRectGetWidth(self.menuDragAffordanceView.bounds);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.menuDragAffordanceView.progress >= 1.f)
    {
        [self presentViewController:self.menuViewController
                           animated:YES
                         completion:NULL];
    }
    else
    {
        self.menuDragAffordanceView.progress = 0.f;
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[SCOverlayPresentTransition alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[SCOverlayDismissTransition alloc] init];
}

@end
