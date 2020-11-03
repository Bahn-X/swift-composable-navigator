import Foundation

struct ScreenState: Hashable, Identifiable {
  struct Next: Hashable {
    let route: Route
    let presentationStyle: ScreenPresentationStyle
  }

  let id: ScreenID
  let parent: ScreenID?
  var next: Next?
}

extension ScreenState {
  var push: Route? {
    next.flatMap { next in
      next.presentationStyle == .push ? next.route: nil
    }
  }

  var sheet: Route? {
    next.flatMap { next in
      next.presentationStyle == .sheet ? next.route: nil
    }
  }
}
