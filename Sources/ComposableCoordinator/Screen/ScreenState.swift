import Foundation

struct ScreenState: Hashable, Identifiable {
  let id: ScreenID
  let parent: ScreenID?
  let content: AnyRoute
  var next: ScreenID?
}
