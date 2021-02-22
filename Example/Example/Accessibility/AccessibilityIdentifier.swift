import SwiftUI

struct AccessibilityIdentifier {
    let value: String
}

extension View {
    func accessibility(identifier: AccessibilityIdentifier) -> some View {
        accessibility(identifier: identifier.value)
    }
}

extension AccessibilityIdentifier {
  enum HomeScreen {
    static let settingsNavigationBarItem = AccessibilityIdentifier(value: "home.settings.open")

    static func detail(for id: String) -> AccessibilityIdentifier {
      AccessibilityIdentifier(value: "detail.\(id)")
    }

    static func detailSettings(for id: String) -> AccessibilityIdentifier {
      AccessibilityIdentifier(value: "detail.\(id).settings")
    }
  }

  struct SettingsScreen {
    let prefix: String

    var shortcutsSheet: AccessibilityIdentifier {
      AccessibilityIdentifier(value: "\(prefix).settings.shortcuts.sheet")
    }

    var shortcutsPush: AccessibilityIdentifier {
      AccessibilityIdentifier(value: "\(prefix).settings.shortcuts.push")
    }
  }

  struct DetailScreen {
    let id: String

    var shortcuts: AccessibilityIdentifier {
      AccessibilityIdentifier(value: "detail.\(id).shortcuts")
    }

    var settings: AccessibilityIdentifier {
      AccessibilityIdentifier(value: "detail.\(id).settings")
    }
  }

  struct NavigationShortcuts {
    let prefix: String

    var detailShortcuts: AccessibilityIdentifier {
      AccessibilityIdentifier(value: "\(prefix).detailShortcuts")
    }

    var detailSettings: AccessibilityIdentifier {
      AccessibilityIdentifier(value: "\(prefix).detailSettings")
    }

    var detailSettingsShortcutsPush: AccessibilityIdentifier {
      AccessibilityIdentifier(value: "\(prefix).detailSettingsShortcutsPush")
    }

    var detailSettingsShortcutsSheet: AccessibilityIdentifier {
      AccessibilityIdentifier(value: "\(prefix).detailSettingsShortcutsSheet")
    }

    var homeSettings: AccessibilityIdentifier {
      AccessibilityIdentifier(value: "\(prefix).homeSettings")
    }

    var home: AccessibilityIdentifier {
      AccessibilityIdentifier(value: "\(prefix).home")
    }
  }
}
