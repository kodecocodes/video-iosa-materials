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

final class ViewController: UIViewController {
  //MARK:- IB Outlets
  
  @IBOutlet private var tableView: TableView! {
    didSet { tableView.handleSelection = showItem }
  }

  @IBOutlet private var menuButton: UIButton!
  @IBOutlet private var titleLabel: UILabel!

  @IBOutlet private var menuHeightConstraint: NSLayoutConstraint!
  @IBOutlet private var menuButtonTrailingConstraint: NSLayoutConstraint!

  //MARK:- Variables
  
  private var slider: HorizontalItemSlider!
  private var menuIsOpen = false
}

//MARK:- UIViewController
extension ViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    slider = HorizontalItemSlider(in: view) { [unowned self] item in
      self.tableView.addItem(item)
      self.transitionCloseMenu()
    }
    titleLabel.superview!.addSubview(slider)
  }
}

//MARK:- private
private extension ViewController {
  @IBAction func toggleMenu() {
    menuIsOpen.toggle()
    titleLabel.text = menuIsOpen ? "Select Item!" : "Packing List"
    view.layoutIfNeeded()

    let constraints = titleLabel.superview!.constraints
    constraints.first {
      $0.firstItem === titleLabel
      && $0.firstAttribute == .centerX
    }?.constant = menuIsOpen ? -100 : 0
    constraints.first { $0.identifier == "Title Center Y" }!.isActive = false
    let constraint = NSLayoutConstraint(
      item: titleLabel!, attribute: .centerY,
      relatedBy: .equal,
      toItem: titleLabel.superview, attribute: .centerY,
      multiplier: menuIsOpen ? 2 / 3 : 1, constant: 0
    )
    constraint.identifier = "Title Center Y"
    constraint.priority = .defaultHigh
    constraint.isActive = true

    menuHeightConstraint.constant = menuIsOpen ? 200 : 80
    menuButtonTrailingConstraint.constant = menuIsOpen ? 16 : 8

    UIView.animate(
      withDuration: 1 / 3, delay: 0,
      options: .curveEaseIn,
      animations: {
        self.menuButton.transform = .init(rotationAngle: self.menuIsOpen ? .pi / 4 : 0)
        self.view.layoutIfNeeded()
      }
    )
  }

  func showItem(_ item: Item) {
    let imageView = UIImageView(item: item)
    imageView.backgroundColor = .init(white: 0, alpha: 0.5)
    imageView.layer.cornerRadius = 5
    imageView.layer.masksToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(imageView)

    let bottomConstraint = imageView.bottomAnchor.constraint(
      equalTo: view.bottomAnchor, constant: imageView.frame.height
    )
    let widthConstraint = imageView.widthAnchor.constraint(
      equalTo: view.widthAnchor, multiplier: 1 / 3, constant: -50
    )
    NSLayoutConstraint.activate([
      bottomConstraint,
      widthConstraint,
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
    ])

    view.layoutIfNeeded()

    UIView.animate(withDuration: 0.8) {
      bottomConstraint.constant = imageView.frame.height * -2
      widthConstraint.constant = 0
      self.view.layoutIfNeeded()
    }

    UIView.animate(
      withDuration: 2 / 3, delay: 2,
      animations: {
        bottomConstraint.constant = imageView.frame.height
        widthConstraint.constant = -50
        self.view.layoutIfNeeded()
      },
      completion: { _ in imageView.removeFromSuperview() }
    )
  }

  func transitionCloseMenu() {
    delay(seconds: 0.35, execute: toggleMenu)
  }
}

private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}
