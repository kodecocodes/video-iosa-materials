import UIKit

enum Item: String, CaseIterable {
  case iceCreamMoney = "Ice cream money"
  case greatWeather = "Great weather"
  case beachBall = "Beach ball"
  case swimTrunks = "Swim trunks"
  case bikini = "Bikini"
  case beachGames = "Beach games"
  case surfboard = "Surfboard"
  case cocktailMood = "Cocktail mood"
  case sunglasses = "Sunglasses"
  case flipFlops = "Flip flops"
}

extension UIImage {
  convenience init(item: Item) {
    self.init(named: item.rawValue)!
  }
}

extension UIImageView {
  convenience init(item: Item) {
    self.init( image: .init(item: item) )
  }
}
