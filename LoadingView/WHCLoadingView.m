//
//  WHCLoadingView.m
//  WHCAPP
//
//  Created by Haochen Wang on 11/30/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCLoadingView.h"

#define ANIMATINGCOLOR [UIColor whiteColor]
static const CGFloat kDGActivityIndicatorDefaultSize = 40.0f;

@interface WHCLoadingView () {
    CALayer *_animationLayer;
}

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic) CGFloat size;
@property (nonatomic, readonly) BOOL animating;

@end

@implementation WHCLoadingView

SINGLETON_implementation(WHCLoadingView)

+(void)showLoading
{
    [[WHCLoadingView sharedWHCLoadingView] startAnimating];
}

+(void)hideLoading
{
    [[WHCLoadingView sharedWHCLoadingView] stopAnimating];
}

-(id)init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    _size = kDGActivityIndicatorDefaultSize;
    self.frame = CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.bounds.size.width / 5.0f, [UIApplication sharedApplication].keyWindow.bounds.size.height / 7.0f);
    self.center = [UIApplication sharedApplication].keyWindow.center;
    _tintColor = ANIMATINGCOLOR;
    self.userInteractionEnabled = NO;
    self.hidden = YES;
    _animationLayer = [[CALayer alloc] init];
    [self.layer addSublayer:_animationLayer];
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self startAnimating];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _animationLayer.frame = self.bounds;
    BOOL animating = _animating;
    if (animating)
    {
        [self stopAnimating];
    }
    [self setupAnimation];
    if (animating)
    {
        [self startAnimating];
    }
}

- (void)setupAnimation
{
    _animationLayer.sublayers = nil;
    CGSize size = CGSizeMake(_size, _size);
    CGFloat duration = 1.0f;
    NSArray *beginTimes = @[@0.1f, @0.2f, @0.3f, @0.4f, @0.5f];
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2f :0.68f :0.18f :1.08f];
    CGFloat lineSize = size.width / 9;
    CGFloat x = (_animationLayer.bounds.size.width - size.width) / 2;
    CGFloat y = (_animationLayer.bounds.size.height - size.height) / 2;

        // Animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    animation.removedOnCompletion = NO;

    animation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    animation.values = @[@1.0f, @0.4f, @1.0f];
    animation.timingFunctions = @[timingFunction, timingFunction];
    animation.repeatCount = HUGE_VALF;
    animation.duration = duration;

    for (int i = 0; i < 5; i++)
    {
        CAShapeLayer *line = [CAShapeLayer layer];
        UIBezierPath *linePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, lineSize, size.height) cornerRadius:lineSize / 2];

        animation.beginTime = [beginTimes[i] floatValue];
        line.fillColor = _tintColor.CGColor;
        line.path = linePath.CGPath;
        [line addAnimation:animation forKey:@"animation"];
        line.frame = CGRectMake(x + lineSize * 2 * i, y, lineSize, size.height);
        [_animationLayer addSublayer:line];
    }
    _animationLayer.speed = 0.0f;
}

- (void)startAnimating {
    if (!_animationLayer.sublayers)
    {
        [self setupAnimation];
    }
    self.hidden = NO;
    _animationLayer.speed = 1.0f;
    _animating = YES;
    [KEYWindow addSubview:self];
}

- (void)stopAnimating
{
    _animationLayer.speed = 0.0f;
    _animating = NO;
    self.hidden = YES;
    [self removeFromSuperview];
}


@end
