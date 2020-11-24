import Foundation

public enum ScreenPresentationStyle: Hashable {
  case push
  case sheet(allowsPush: Bool = true)
}
