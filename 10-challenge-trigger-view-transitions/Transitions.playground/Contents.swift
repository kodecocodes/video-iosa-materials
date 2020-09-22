import PlaygroundSupport
import UIKit

let view = TransitionsView( frame: .init(x: 0, y: 0, width: 400, height: 400) )
PlaygroundPage.current.liveView = view
/*:
 
 # Transitions
 Want to compare view transitions? It's your lucky day! We've crafted this playground just for you.
 
 1. Already displayed are the 3 general types of transitions available. Click the "Animate" button again after they've all vanished to see them transition back into view.
 2. Note that the `transitionCurl...` transitions only work well in one situation. CurlUp for hiding a view, and CurlDown for showing.
 3. `transitionFlipFrom...` has 4 possible directions: Top, Bottom, Right and Left. Try all four!
 4. Try adding easing options to similar transitions to see how they interact! (`.curveEaseIn`, `.curveEaseOut`, `.curveEaseInOut`, `.curveLinear`)
*/
view.duration = 2

let beachballOptions: UIView.AnimationOptions = [.transitionFlipFromTop]

let drinkOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
let icecreamTransitionIn: UIView.AnimationOptions = [.transitionCurlUp]
let icecreamTransitionOut: UIView.AnimationOptions = [.transitionCurlDown]
//: The animation code is below, for easy reference. The remainder of the supporting code can be found in the "Sources" folder.
extension TransitionsView {
  @objc func transition() {
    UIView.transition(
      with: beachBall,
      duration: duration,
      options: beachballOptions,
      animations: { self.beachBall.subviews[0].isHidden = self.shouldHide }
    )
    
    UIView.transition(
      with: drink,
      duration: duration,
      options: drinkOptions,
      animations: { self.drink.subviews[0].isHidden = self.shouldHide }
    )

    UIView.transition(
      with: iceCream,
      duration: duration,
      options: shouldHide ? icecreamTransitionIn : icecreamTransitionOut,
      animations: { self.iceCream.subviews[0].isHidden = self.shouldHide }
    )
    
    self.shouldHide.toggle()
  }
}
view.button.addTarget(view, action: #selector(view.transition), for: .touchUpInside)
