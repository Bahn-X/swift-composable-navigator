import Foundation

struct ScreenState: Equatable {
    struct Next: Equatable {
        let route: Route
        let presentationStyle: ScreenPresentationStyle
    }

    let id: ScreenID
    let parent: ScreenID?
    var next: Next?
}
