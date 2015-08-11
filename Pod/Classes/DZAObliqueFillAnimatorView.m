//
//  TVRObliqueView.m
//  tuoVR
//
//  Created by Davide Di Stefano on 30/07/15.
//  Copyright © 2015 EvolvedPlanet. All rights reserved.
//

#import "DZAObliqueFillAnimatorView.h"

@interface DZAObliqueFillAnimatorView()
{
    double _frameTimestamp;
    double _initialAnimationTimestamp;
    double _animationDuration;
    double _animationInitialFillPercentage;
    BOOL _isOpening;
    CADisplayLink *_displayLink;
}

@property (nonatomic, copy) void (^animationCompletion)(void);

@end

@implementation DZAObliqueFillAnimatorView

- (instancetype) initWithFrame:(CGRect)aRect
{
    if (self = [super initWithFrame:aRect])
    {
        _isAnimating = NO;
        _isOpening = NO;
        _frameTimestamp = -1;
        _initialAnimationTimestamp = -1;
        _startsFromLeft = YES;
    }
    return self;
}

-(void) dealloc
{
    [_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

#define RADIANS_FROM_DEGREES(angle) ((angle) / 180.0 * M_PI)

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, _backColor.CGColor);

    CGMutablePathRef path = CGPathCreateMutable();

    // intersection for a line of 'angle' degrees at the end of the frame width
    float intersection = self.bounds.size.width * sin(RADIANS_FROM_DEGREES(_angle));
    
    // this is the clip path, the area of allowed drawing. The excluded region will be transparent
    if (_startsFromLeft)
    {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, self.frame.size.width, intersection);
    } else
    {
        CGContextMoveToPoint(context, 0, intersection);
        CGContextAddLineToPoint(context, self.frame.size.width, 0);
    }
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    CGContextAddLineToPoint(context, 0, self.frame.size.height);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGPathRelease(path);

    // fill the entire rectangle with the background color
    CGContextFillRect(context, [self bounds]);
    if (_fillPercentage > 0)
    {
        // fill the circle proportionally with the fill percentage value
        CGContextSetFillColorWithColor(context, _fillColor.CGColor);
        float obliqueWidth = sqrtf( (self.bounds.size.width * self.bounds.size.width) + (self.bounds.size.height * self.bounds.size.height) );
        float currentOblique = obliqueWidth * _fillPercentage;
        CGFloat xOffset = currentOblique - _circleOffset.x;
        CGFloat yOffset = currentOblique - _circleOffset.y;
        CGRect ellipseRect = CGRectMake((_startsFromLeft? -xOffset: xOffset), -yOffset, currentOblique * 2, currentOblique * 2);
        CGContextAddEllipseInRect(context, ellipseRect);
        CGContextFillPath(context);
    }
}

// starts the fill animation
-(void) animateOpeningWithDuration:(double) duration completion:(void(^)(void)) completion isOpening:(BOOL) isOpening;
{
    if (!_isAnimating)
    {
        self.animationCompletion = completion;
        _isAnimating = YES;
        _isOpening = isOpening;
        _frameTimestamp = -1;
        _initialAnimationTimestamp = -1;
        _animationInitialFillPercentage = (_isOpening? _fillPercentage: 1.0 - _fillPercentage);
        _animationDuration = duration;
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAnimation:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

-(void) animateOpeningWithDuration:(double) duration completion:(void(^)(void)) completion;
{
    [self animateOpeningWithDuration:duration completion:completion isOpening:YES];
}

-(void) animateClosingWithDuration:(double) duration completion:(void(^)(void)) completion;
{
    [self animateOpeningWithDuration:duration completion:completion isOpening:NO];
}

- (void) updateAnimation:(CADisplayLink *) displayLink
{
    double currentTime = [displayLink timestamp];
    if (_frameTimestamp < 0)
    {
        _initialAnimationTimestamp = currentTime;
    }
    _frameTimestamp = currentTime;
    double passedTimeFromStart = _frameTimestamp - _initialAnimationTimestamp + (_animationInitialFillPercentage * _animationDuration);
    _fillPercentage = passedTimeFromStart / _animationDuration;
    if (!_isOpening)
    {
        _fillPercentage = 1.0 - _fillPercentage;
    }
    [self setNeedsDisplay];
    
    if (passedTimeFromStart > _animationDuration)
    {
        [_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _isAnimating = NO;
        if (self.animationCompletion)
        {
            self.animationCompletion();
            self.animationCompletion = nil;
        }
    }
}

-(void) setFillPercentage:(CGFloat)fillPercentage
{
    _fillPercentage = fillPercentage;
    [self setNeedsDisplay];
}

-(void) setBackColor:(UIColor *)backColor
{
    _backColor = backColor;
    [self setNeedsDisplay];
}

-(void) setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

@end
