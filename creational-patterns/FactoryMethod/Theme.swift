import UIKit

protocol Theme {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }

}

class LightTheme: Theme {
    let backgroundColor = .white
    let textColor = .darkGray
    init() {

    }
}

class DarkTheme: Theme {
    let backgroundColor = .darkGray
    let textColor = .white
    init() {

    }
}

class BlueTheme: Theme {
    let backgroundColor = .blue
    let textColor = .white
    init() {

    }
}

protocol ThemeCreator {
    static func makeTheme(profile: ColorProfile) -> Theme
}

public enum ColorProfile {
    case light
    case dark
    case blue
}


// default protocol extension, so the specific class don't need to implement
extension ThemeCreator {
    static func makeTheme(profile: ColorProfile) -> Theme {
        switch profile {
        case .light:
            return LightTheme()
        case .dark:
            return DarkTheme()
        case .blue:
            return BlueTheme()
        }
    }
}

class MyThemeCreator: ThemeCreator {

}

// using this all, -> exact type is hidden from the caller, so they doesn't care about it
let lightTheme = MyThemeCreator.makeTheme(profile: .light)
let darkTheme = MyThemeCreator.makeTheme(profile: .dark)
let blueTheme = MyThemeCreator.makeTheme(profile: .blue)