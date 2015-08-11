# DZAObliqueFillAnimatorView

A custom view that has an oblique transparent cut on the top and it can be filled with an animated circle

A demo of the animation:

![](https://raw.githubusercontent.com/Dzamir/DZAObliqueFillAnimatorView/master/demo.gif)

(Video available [here](https://raw.githubusercontent.com/Dzamir/DZAObliqueFillAnimatorView/master/demo.mp4))

Screenshots:

![](https://raw.githubusercontent.com/Dzamir/DZAObliqueFillAnimatorView/master/1.png)

![](https://raw.githubusercontent.com/Dzamir/DZAObliqueFillAnimatorView/master/2.png)

![](https://raw.githubusercontent.com/Dzamir/DZAObliqueFillAnimatorView/master/3.png)


## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

The view supports Interface Builder integration: you just need to drag a UIView and change the class to DZAObliqueFillAnimatorView

![](https://raw.githubusercontent.com/Dzamir/DZAObliqueFillAnimatorView/master/4.png)

From the IB you can change the parameters and colors to match your app style.

From the code you call

    [_obliqueView animateOpeningWithDuration:0.5 completion:nil];

or 

    [_obliqueView animateClosingWithDuration:0.5 completion:nil];

to animate the transition.

## Installation

DZAObliqueFillAnimatorView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DZAObliqueFillAnimatorView"
```

## Author

Davide Di Stefano, dzamirro@gmail.com

## License

DZAObliqueFillAnimatorView is available under the MIT license. See the LICENSE file for more info.
