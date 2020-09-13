import PlaygroundSupport
import UIKit

let view = SpringsView( frame: .init(x: 0, y: 0, width: 400, height: 700) )
PlaygroundPage.current.liveView = view
/*:
 
 # Springs!
 Change the properties below to quickly adjust the springy qualities of each view. Then, click the "Animate!" button in the live view to compare the effects!
*/
view.duration = 2

view.beachBallSpringDamping = 0.1
view.beachBallSpringInitialVelocity = 0

view.drinkSpringDamping = 0.5
view.drinkSpringInitialVelocity = 50

view.iceCreamSpringDamping = 1
view.iceCreamSpringInitialVelocity = 0
/*:
 **Remember:**
 
 *Damping* is a ratio ranging from 0 *(snappier oscilation)* to 1 *(no oscilation)*.
 
 *Initial Velocity* is a multiplier used to calculate the view's initial velocity in points/second. Here, 0 equates to *no velocity* and 1 equates to the velocity required for the view to travel the entire animated distance in 1 second.
 */
//: The animation code is below, for easy reference. The remainder of the supporting code can be found in the "Sources" folder.
extension SpringsView {
  @objc func animate() {
    UIView.animate(
      withDuration: duration, delay: 0,
      usingSpringWithDamping: beachBallSpringDamping,
      initialSpringVelocity: beachBallSpringInitialVelocity,
      animations: {
        view.beachBallYConstraint.constant *= -1
        view.layoutIfNeeded()
    }
    )
    UIView.animate(withDuration: duration, delay: 0.0,
      usingSpringWithDamping: drinkSpringDamping,
      initialSpringVelocity: drinkSpringInitialVelocity,
      animations: {
        view.drinkYConstraint.constant *= -1
        view.layoutIfNeeded()
      }
    )
    UIView.animate(withDuration: duration, delay: 0.0,
      usingSpringWithDamping: iceCreamSpringDamping,
      initialSpringVelocity: iceCreamSpringInitialVelocity,
      animations: {
        view.iceCreamYConstraint.constant *= -1
        view.layoutIfNeeded()
      }
    )
  }
}
view.button.addTarget(view, action: #selector(view.animate), for: .touchUpInside)
