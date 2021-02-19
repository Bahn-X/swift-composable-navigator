@testable import ComposableDeeplinking

extension Deeplink {
    enum Stub {
        static let deeplink = Deeplink(
          components: [
              DeeplinkComponent(
                  name: "test",
                  arguments: [
                      "id": .value("1"),
                      "message": .value("Hello World"),
                      "flag": .flag
                  ]
              )
          ]
      )
    }
}
