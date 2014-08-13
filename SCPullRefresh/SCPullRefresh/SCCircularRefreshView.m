//
//  SCCircularRefreshView.m
//  newSponia
//
//  Created by Singro on 5/27/14.
//  Copyright (c) 2014 Sponia. All rights reserved.
//

#import "SCCircularRefreshView.h"

#import "DACircularProgressView.h"

static NSString* const kRotationAnimation = @"RotationAnimation";

@interface SCCircularRefreshView ()

@property (nonatomic, strong) DACircularProgressView *circleView;
@property (nonatomic, strong) UIImageView *loadingImageView;

@property (nonatomic, assign) BOOL isRotating;
@property (nonatomic, assign) BOOL endWillCalled;
@property (nonatomic, assign) BOOL isEndingAnimation;

@end

@implementation SCCircularRefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isLoadMore = NO;
        
        self.isRotating = NO;
        self.endWillCalled = NO;
        self.isEndingAnimation = NO;
        
        self.circleView = [[DACircularProgressView alloc] init];
        self.circleView.frame = (CGRect){-12.5, -12.5, 25, 25};
        self.circleView.roundedCorners = 3;
        self.circleView.trackTintColor = [UIColor clearColor];
        self.circleView.progressTintColor = [UIColor colorWithRed:0.333 green:0.691 blue:1.000 alpha:1.000];
        self.circleView.hidden = YES;
        [self addSubview:self.circleView];
        
        UIImage *loadingImage = [UIImage imageNamed:@"Loading"];
        loadingImage = [loadingImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.loadingImageView = [[UIImageView alloc] initWithImage:loadingImage];
        self.loadingImageView.tintColor = [UIColor colorWithRed:0.333 green:0.691 blue:1.000 alpha:1.000];

        self.loadingImageView.frame = self.circleView.frame;
        self.loadingImageView.centerX = 0;
        self.loadingImageView.centerY = 0;
        self.loadingImageView.hidden = YES;
        self.loadingImageView.layer.allowsEdgeAntialiasing = YES;
        [self addSubview:self.loadingImageView];
        
        self.circleView.transform = CGAffineTransformMakeRotation(M_PI);

    }
    return self;
}

#pragma mark - Public methods

- (void)setTimeOffset:(CGFloat)timeOffset {
    
    _timeOffset = timeOffset;
    
    if (self.isRotating) {
        return;
    }
    
    self.circleView.hidden = NO;

    [self.circleView setProgress:timeOffset animated:YES];
    
    
    
}

- (void)setIsLoadMore:(BOOL)isLoadMore {
    _isLoadMore = isLoadMore;
    
    if (self.isLoadMore) {
        self.circleView.transform = CGAffineTransformIdentity;
    } else {
        self.circleView.transform = CGAffineTransformMakeRotation(M_PI);
        self.loadingImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    

}

- (void)beginRefreshing {
    
    self.isRotating = YES;
    
    if (self.isEndingAnimation) {
        return;
    }
    
    [self.loadingImageView.layer addAnimation:[self createRotationAnimation] forKey:kRotationAnimation];

    self.loadingImageView.alpha = 1.0;
    self.circleView.alpha = 1.0;
    [UIView animateWithDuration:0.2 animations:^{
        self.loadingImageView.alpha = 1.0;
        self.circleView.alpha = 0.6;
    } completion:^(BOOL finished) {
        self.loadingImageView.hidden = NO;
        self.circleView.hidden = YES;
        self.loadingImageView.alpha = 1.0;
        self.circleView.alpha = 1.0;
    }];

    
}

- (void)endRefreshing {
    
    if (self.isEndingAnimation) {
        return;
    }

    self.isEndingAnimation = YES;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.loadingImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.loadingImageView.hidden = YES;
        self.circleView.hidden = YES;
        self.loadingImageView.alpha = 1.0;
        [self.loadingImageView.layer removeAnimationForKey:kRotationAnimation];
        self.isRotating = NO;
        self.isEndingAnimation = NO;
    }];
    
    
}


#pragma mark - Private methods

- (void)didEndEndAnimation {
    
    self.isEndingAnimation = NO;
    self.endWillCalled = NO;
}

- (CAAnimation *)createRotationAnimation {
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [rotationAnimation setValue:kRotationAnimation forKey:@"id"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    rotationAnimation.duration = 0.8f;
    rotationAnimation.repeatCount = NSUIntegerMax;
    rotationAnimation.speed = 1.0f;
    rotationAnimation.removedOnCompletion = YES;
    
    return rotationAnimation;
}

@end