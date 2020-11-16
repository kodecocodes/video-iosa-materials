import Foundation

public extension Selector {
  /// Wraps a closure in a `Selector`.
  /// - Note: Callable as a function.
  final class Perform: NSObject {
    public init(_ perform: @escaping () -> Void) {
      self.perform = perform
      super.init()
    }

    private let perform: () -> Void
  }
}

//MARK: public
public extension Selector.Perform {
  @objc func callAsFunction() { perform() }
  var selector: Selector { #selector(callAsFunction) }
}
