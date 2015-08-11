//
//  DZAViewController.m
//  DZAObliqueFillAnimatorView
//
//  Created by Davide Di Stefano on 07/30/2015.
//  Copyright (c) 2015 Davide Di Stefano. All rights reserved.
//

#import "DZAViewController.h"
#import "DZAObliqueFillAnimatorView.h"

@interface DZAViewController ()
@property (weak, nonatomic) IBOutlet DZAObliqueFillAnimatorView *obliqueView;
@property (readwrite, nonatomic) BOOL isOpened;


@end

@implementation DZAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isOpened = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animateTouchUpInside:(id)sender
{
    if (_isOpened)
    {
        [_obliqueView animateOpeningWithDuration:0.5 completion:^{
            _isOpened = !_isOpened;
        }];
    } else
    {
        [_obliqueView animateClosingWithDuration:0.5 completion:^{
            _isOpened = !_isOpened;
        }];
    }
}

- (IBAction)sliderValueChanged:(UISlider *)sender
{
    _obliqueView.fillPercentage = sender.value;
}

@end
