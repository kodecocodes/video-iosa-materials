/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class ViewController: UIViewController {
  @IBOutlet var background: UIImageView!
  
  @IBOutlet var summaryIcon: UIImageView!
  @IBOutlet var summary: UILabel!
  
  @IBOutlet var flightNumberLabel: UILabel!
  @IBOutlet var gateNumberLabel: UILabel!
  @IBOutlet var originLabel: UILabel!
  @IBOutlet var destinationLabel: UILabel!
  @IBOutlet var plane: UIImageView!
  
  @IBOutlet var statusLabel: UILabel!
  @IBOutlet var statusBanner: UIImageView!

  private let snowView = SnowView( frame: .init(x: -150, y:-100, width: 300, height: 50) )
}

//MARK:- UIViewController
extension ViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    // Add the snow effect layer
    let snowClipView = UIView( frame: view.frame.offsetBy(dx: 0, dy: 50) )
    snowClipView.clipsToBounds = true
    snowClipView.addSubview(snowView)
    view.addSubview(snowClipView)

    // Start rotating the flights
    changeFlight(to: .londonToParis, animated: false)
  }
}

private extension ViewController {
  //MARK:- Animations

  func fade(to image: UIImage, showEffects: Bool) {
		//TODO: Create a crossfade animation for the background

    //TODO: Create a fade animation for snowView
  }
  
  func move(label: UILabel, text: String, offset: CGPoint) {
    //TODO: Animate a label's translation property
  }
  
  func cubeTransition(label: UILabel, text: String) {
		//TODO: Create a faux rotating cube animation
  }
  
  func depart() {
		//TODO: Animate the plane taking off and landing
  }
  
  func changeSummary(to summaryText: String) {
		//TODO: Animate the summary text
  }

  func changeFlight(to flight: Flight, animated: Bool = false) {
		// populate the UI with the next flight's data
    background.image = UIImage(named: flight.weatherImageName)
    originLabel.text = flight.origin
    destinationLabel.text = flight.destination
    flightNumberLabel.text = flight.number
    gateNumberLabel.text = flight.gateNumber
    statusLabel.text = flight.status
    summary.text = flight.summary

    if animated {
      // TODO: Call your animation
    } else {

    }
    
    // schedule next flight
    delay(seconds: 3) {
      self.changeFlight(
        to: flight.isTakingOff ? .parisToRome : .londonToParis,
        animated: true
      )
    }
  }
  
  //MARK:- utility methods
  func duplicate(_ label: UILabel) -> UILabel {
    let newLabel = UILabel(frame: label.frame)
    newLabel.font = label.font
    newLabel.textAlignment = label.textAlignment
    newLabel.textColor = label.textColor
    newLabel.backgroundColor = label.backgroundColor
    return newLabel
  }
}

private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}
