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
    CADisplayLink *_displayLink;
}

@end

@implementation DZAObliqueFillAnimatorView

- (instancetype) initWithFrame:(CGRect)aRect
{
    if (self = [super initWithFrame:aRect])
    {
        _isAnimating = NO;
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
-(void) animateWithDuration:(double) duration
{
    if (!_isAnimating)
    {
        _isAnimating = YES;
        _frameTimestamp = -1;
        _initialAnimationTimestamp = -1;
        _animationDuration = duration;
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAnimation:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void) updateAnimation:(CADisplayLink *) displayLink
{
    double currentTime = [displayLink timestamp];
    if (_frameTimestamp < 0)
    {
        _frameTimestamp = 0;
        _initialAnimationTimestamp = currentTime;
    }
    _frameTimestamp = currentTime;
    double passedTimeFromStart = _frameTimestamp - _initialAnimationTimestamp;
    _fillPercentage = passedTimeFromStart / _animationDuration;
    [self setNeedsDisplay];
    
    if (passedTimeFromStart > _animationDuration)
    {
        [_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _isAnimating = NO;
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
