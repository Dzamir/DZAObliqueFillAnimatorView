//
//  TVRObliqueView.h
//  tuoVR
//
//  Created by Davide Di Stefano on 30/07/15.
//  Copyright © 2015 EvolvedPlanet. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface DZAObliqueFillAnimatorView : UIView

@property (readwrite, nonatomic) IBInspectable CGFloat fillPercentage;
@property (readwrite, nonatomic) IBInspectable UIColor * backColor;
@property (readwrite, nonatomic) IBInspectable UIColor * fillColor;
@property (readwrite, nonatomic) IBInspectable CGFloat angle;
@property (readwrite, nonatomic) IBInspectable CGPoint circleOffset;
@property (readwrite, nonatomic) IBInspectable BOOL startsFromLeft;

@property (readonly, nonatomic) BOOL isAnimating;
-(void) animateWithDuration:(double) duration;

@end
