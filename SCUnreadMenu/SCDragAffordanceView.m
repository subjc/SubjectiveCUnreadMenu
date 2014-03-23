//
//  SCDragAffordanceView.m
//  SCUnreadMenu
//
//  Created by Sam Page on 16/03/14.
//  Copyright (c) 2014 Subjective-C. All rights reserved.
//

#import "SCDragAffordanceView.h"
#import "SCSpringExpandView.h"

@interface SCDragAffordanceView ()

@property (nonatomic, strong) NSArray *springExpandViews;

@end

@implementation SCDragAffordanceView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {        
        SCSpringExpandView *springExpandView1 = [[SCSpringExpandView alloc] initWithFrame:CGRectZero];
        [self addSubview:springExpandView1];
        
        SCSpringExpandView *springExpandView2 = [[SCSpringExpandView alloc] initWithFrame:CGRectZero];
        [self addSubview:springExpandView2];
        
        SCSpringExpandView *springExpandView3 = [[SCSpringExpandView alloc] initWithFrame:CGRectZero];
        [self addSubview:springExpandView3];
        
        self.springExpandViews = @[springExpandView1, springExpandView2, springExpandView3];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat interItemSpace = CGRectGetWidth(self.bounds) / self.springExpandViews.count;
    
    NSInteger index = 0;
    for (SCSpringExpandView *springExpandView in self.springExpandViews)
    {
        springExpandView.frame = CGRectMake(interItemSpace * index, 0.f, 4.f, CGRectGetHeight(self.bounds));
        index++;
    }
}

#pragma mark - Property overrides

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CGFloat progressInterval = 1.0f / self.springExpandViews.count;
    
    NSInteger index = 0;
    for (SCSpringExpandView *springExpandView in self.springExpandViews)
    {
        BOOL expanded = ((index * progressInterval) + progressInterval < progress);
    
        if (progress >= 1.f)
        {
            [springExpandView setColor:[UIColor redColor]];
        }
        else if (expanded)
        {
            [springExpandView setColor:[UIColor blackColor]];
        }
        else
        {
            [springExpandView setColor:[UIColor grayColor]];
        }
        
        [springExpandView setExpanded:expanded animated:YES];
        index++;
    }
}

@end
