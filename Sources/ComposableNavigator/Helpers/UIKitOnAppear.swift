import UIKit
import SwiftUI

struct UIKitAppear: UIViewControllerRepresentable {
  final class UIAppearViewController: UIViewController {
    var action: () -> Void = {}

    override func viewDidAppear(_ animated: Bool) {
      action()
    }
  }

  let action: () -> Void

  func makeUIViewController(context: Context) -> UIAppearViewController {
    let vc = UIAppearViewController()
    vc.action = action
    return vc
  }

  func updateUIViewController(_ controller: UIAppearViewController, context: Context) { }
}

extension View {
  /// Unfortunately, onAppear is broken in SwiftUI iOS >14.
  /// Therefore, we fallback to UIKit's viewDidAppear method in `Routed<Content>` to determine when a screen is shown.
  /// [Apple Developer Forums Discussion](https://developer.apple.com/forums/thread/655338)
  func uiKitOnAppear(_ perform: @escaping () -> Void) -> some View {
    self.background(UIKitAppear(action: perform))
  }
}
