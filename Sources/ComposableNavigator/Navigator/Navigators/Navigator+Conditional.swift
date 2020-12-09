import Foundation

public extension Navigator {
    static func conditional(
        either: Navigator,
        or: Navigator,
        basedOn condition: @escaping () -> Bool
    ) -> Navigator {
        Navigator(
            lateInit: { dataSource in
                Navigator(
                    buildPath: { path in
                        if condition() {
                            return either.lateInit(dataSource: dataSource).build(path: path)
                        } else {
                            return or.lateInit(dataSource: dataSource).build(path: path)
                        }
                    },
                    parse: { components in
                        if condition() {
                            return either.lateInit(dataSource: dataSource).parse(components: components)
                        } else {
                            return or.lateInit(dataSource: dataSource).parse(components: components)
                        }
                    }
                )
            }
        )
    }
}
