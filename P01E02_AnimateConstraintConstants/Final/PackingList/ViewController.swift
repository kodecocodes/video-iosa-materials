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
    menuHeightConstraint.constant = menuIsOpen ? 200 : 80

    UIView.animate(
      withDuration: 1 / 3, delay: 0,
      options: .curveEaseIn,
      animations: { self.view.layoutIfNeeded() }
    )
  }

  func showItem(_ item: Item) {
    let imageView = UIImageView(item: item)
    imageView.backgroundColor = .init(white: 0, alpha: 0.5)
    imageView.layer.cornerRadius = 5
    imageView.layer.masksToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(imageView)
  }

  func transitionCloseMenu() {
    delay(seconds: 0.35, execute: toggleMenu)
  }
}

private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}
