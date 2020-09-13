import PlaygroundSupport
import UIKit

let view = OptionsView( frame: .init(x: 0, y: 0, width: 400, height: 700) )
PlaygroundPage.current.liveView = view
/*: 
 
 # Animation Options!
 
 There are different kinds of options available to try on your animations. You can, of course, read the documentation by option+click-ing `UIView.AnimationOptions` below. But, if you wonder what they actually *look like*, here are some experiments to try :
 
 1. Click "Animate!" and compare the animation easing options we've fill in for you. 
 2. There is one more easing option: `.curveLinear`, which applies no easing at all. Try replacing `.curveEaseInOut` with `.curveLinear`.
 3. Try adding `.repeat` to each set of options.
 4. Now add `.autoreverse` to each set of options as well. Notice the interplay of autoreverse and the different types of easing options.
*/
view.duration = 2.0

let beachBallOptions: UIView.AnimationOptions = .curveEaseIn
let drinkOptions: UIView.AnimationOptions = .curveEaseOut
let iceCreamOptions: UIView.AnimationOptions = .curveEaseInOut
//: The animation code is below, for easy reference. The remainder of the supporting code can be found in the "Sources" folder.
extension OptionsView {
  @objc func animate() {
    UIView.animate(
      withDuration: duration, delay: 0,
      options: beachBallOptions,
      animations: {
        view.beachBallYConstraint.constant *= -1
        view.layoutIfNeeded()
      }
    )
    UIView.animate(
      withDuration: duration, delay: 0,
      options: drinkOptions,
      animations: {
        view.drinkYConstraint.constant *= -1
        view.layoutIfNeeded()
      }
    )
    UIView.animate(
      withDuration: duration, delay: 0,
      options: iceCreamOptions,
      animations: {
        view.iceCreamYConstraint.constant *= -1
        view.layoutIfNeeded()
      }
    )
  }
}
view.button.addTarget(view, action: #selector(view.animate), for: .touchUpInside)
