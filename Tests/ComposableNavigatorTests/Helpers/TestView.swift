import SwiftUI

struct TestView: View, Equatable {
  let id: Int
  
  var body: some View {
    EmptyView()
  }

  static func ==(lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }
}
