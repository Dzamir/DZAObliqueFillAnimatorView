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

@end

@implementation DZAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animateTouchUpInside:(id)sender
{
    [_obliqueView animateWithDuration:0.5];
}

- (IBAction)sliderValueChanged:(UISlider *)sender
{
    _obliqueView.fillPercentage = sender.value;
}

@end
