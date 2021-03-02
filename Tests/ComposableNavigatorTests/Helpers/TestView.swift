import SwiftUI

struct TestView: View, Equatable {
  let id: Int
  
  var body: some View {
    Color.red
  }

  static func ==(lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }
}
