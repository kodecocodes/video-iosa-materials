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
  @IBOutlet private var background: UIImageView!

  @IBOutlet private var stackView: UIStackView! {
    didSet {
      for herb in Herb.all {
        let imageView = UIImageView( image: .init(herb: herb) )
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.widthAnchor.constraint(
          equalTo: imageView.heightAnchor,
          multiplier: UIScreen.main.bounds.width / UIScreen.main.bounds.height
        ).isActive = true
        stackView.addArrangedSubview(imageView)
        imageView.addGestureRecognizer(
          TapGestureRecognizer { [unowned self, unowned imageView] in
            self.selectedImage = imageView

            let herbDetails: HerbDetailsViewController = .instantiate {
              .init(coder: $0, herb: herb)
            }!
            self.present(herbDetails, animated: true)
          }
        )
      }
    }
  }

  private(set) var selectedImage: UIImageView!
}

//MARK:- UIViewController
extension ViewController {
  override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

  override func viewWillTransition(
    to size: CGSize,
    with coordinator: UIViewControllerTransitionCoordinator
  ) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(
      alongsideTransition: { _ in
        self.background.alpha = (size.width > size.height) ? 0.25 : 0.55
      }
    )
  }
}
