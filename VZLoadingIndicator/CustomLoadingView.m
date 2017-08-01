//
//  CustomLoadingView.m
//  VezeetaDrBridge
//
//  Created by Yomna Ahmed on 1/10/16.
//  Copyright © 2016 IOS Dev1. All rights reserved.
//

#import "CustomLoadingView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomLoadingView
{
    NSArray *images;
    BOOL active;
    CGFloat delay;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        active = false;
        delay = 0.2;
        
        self.containerView = [UIView new];
        self.containerView.backgroundColor = [UIColor whiteColor];
        self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.containerView];
        
        self.redLineView = [UIView new];
        self.redLineView.backgroundColor = [UIColor redColor];
        self.redLineView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.containerView addSubview:self.redLineView];
        
        self.rotationImageView = [UIImageView new];
        self.rotationImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.rotationImageView.translatesAutoresizingMaskIntoConstraints = 0;
        self.rotationImageView.image = [UIImage imageNamed:@"L.png"];
        [self.containerView addSubview:self.rotationImageView];
        
        images = @[@"VZLoadingIndicatorImages.bundle/L.png", @"VZLoadingIndicatorImages.bundle/L2.png",@"VZLoadingIndicatorImages.bundle/L3.png", @"VZLoadingIndicatorImages.bundle/L4.png",@"VZLoadingIndicatorImages.bundle/L5.png", @"VZLoadingIndicatorImages.bundle/L6.png", @"VZLoadingIndicatorImages.bundle/L7.png"];

        [self setupConstrains];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.containerView.backgroundColor = [UIColor whiteColor];


    }
    return self;
}

- (void)startAnimation {
    if (!active) {
        active = true;
        
        [self rotateToSide:0 dutation:0.2 withDelay:delay + 0.01];
    }
}

- (void)stopAnimation {
   
    if (active) {
        active = false;
        
    }
}

- (void)rotateToSide:(int)index dutation:(CGFloat)duration withDelay:(CGFloat)de
{
    if (active)
    {
        [UIView animateWithDuration:duration delay:duration / 2 options:UIViewAnimationOptionCurveLinear animations:^{
            self.rotationImageView.layer.transform = CATransform3DRotate(self.layer.transform, M_PI_2, 0, 1, 0);
        } completion:^(BOOL finished) {
        
            int i = index + 1;
            if ( i > 5)
                i = 0;
            self.rotationImageView.image = [UIImage imageNamed:images[i]];
            
            [UIView animateWithDuration:duration delay:duration options:UIViewAnimationOptionCurveLinear animations:^{
                self.rotationImageView.layer.transform = CATransform3DRotate(self.layer.transform, 0, 0, 1, 0);

            } completion:^(BOOL finished) {
                [self rotateToSide:i dutation:0.2 withDelay:de];

            }];

    }];
    }
}

- (void)setupConstrains {
    
    NSDictionary *viewDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.containerView, @"containerView", self.rotationImageView,  @"rotationImageView", self.redLineView,  @"redLineView", nil];

    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[containerView(100)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDic]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[containerView(100)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDic]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rotationImageView(50)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDic]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rotationImageView(50)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDic]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[rotationImageView]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDic]];
    
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.rotationImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[redLineView(7)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDic]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rotationImageView]-10-[redLineView]"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:viewDic]];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-45-[redLineView]-45-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:viewDic]];
    
    [self.containerView layoutIfNeeded];
    [self layoutIfNeeded];
    self.containerView.layer.cornerRadius = 10;
    self.containerView.layer.masksToBounds = YES;

}

@end
