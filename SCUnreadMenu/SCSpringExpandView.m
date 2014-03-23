//
//  SCDragAffordanceView.m
//  SCUnreadMenu
//
//  Created by Sam Page on 16/03/14.
//  Copyright (c) 2014 Subjective-C. All rights reserved.
//

#import "SCSpringExpandView.h"

@interface SCSpringExpandView ()

@property (nonatomic, strong) UIView *stretchingView;
@property (nonatomic, assign, getter = isExpanded) BOOL expanded;

@end

@implementation SCSpringExpandView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.stretchingView = [[UIView alloc] initWithFrame:CGRectZero];
        self.stretchingView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.stretchingView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self configureViewsForExpandedState:self.isExpanded animated:NO];
    self.stretchingView.layer.cornerRadius = CGRectGetMidX(self.stretchingView.bounds);
}

#pragma mark - Public

- (void)setExpanded:(BOOL)expanded animated:(BOOL)animated
{
    if (self.isExpanded != expanded)
    {
        [self configureViewsForExpandedState:expanded animated:animated];
    }
}

- (void)setColor:(UIColor *)color
{
    self.stretchingView.backgroundColor = color;
}

#pragma mark - Private

- (void)configureViewsForExpandedState:(BOOL)expanded animated:(BOOL)animated
{
    if (expanded)
    {
        [self expandAnimated:animated];
    }
    else
    {
        [self collapseAnimated:animated];
    }
}

- (void)expandAnimated:(BOOL)animated
{
    void (^expandBlock)() = ^void() {
        self.stretchingView.frame = [self frameForExpandedState];
        self.expanded = YES;
    };
    
    if (animated)
    {
        [self performBlockInAnimation:expandBlock];
    }
    else
    {
        expandBlock();
    }
}

- (void)collapseAnimated:(BOOL)animated
{
    void (^collapseBlock)() = ^void() {
        self.stretchingView.frame = [self frameForCollapsedState];
        self.expanded = NO;
    };
    
    if (animated)
    {
        [self performBlockInAnimation:collapseBlock];
    }
    else
    {
        collapseBlock();
    }
}

- (void)performBlockInAnimation:(void(^)())blockToAnimate
{
    [UIView animateWithDuration:0.5f
                          delay:0.0f
         usingSpringWithDamping:0.4f
          initialSpringVelocity:0.5f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         blockToAnimate();
                     } completion:NULL];
}

#pragma mark - Helpers

- (CGRect)frameForCollapsedState
{
    return CGRectMake(0.f, CGRectGetMidY(self.bounds) - (CGRectGetWidth(self.bounds) / 2.f), CGRectGetWidth(self.bounds), CGRectGetWidth(self.bounds));
}

- (CGRect)frameForExpandedState
{
    return CGRectMake(CGRectGetWidth(self.bounds) / 4.f, 0.f, CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds));
}

@end
