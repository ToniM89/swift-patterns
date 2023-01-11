import Foundation

// For structs there is no need to do extra stuff because
// struct are value types
// for refernce types we need to implement the NSCoying protocoll
// and the beklonging copy method

class Point {
    var x: Int
    var y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

// use extensions here to keep the class code clean
extension Point: CustomStringConvertible {
    var description: String {
        return "Point (\(x), \(y))"
    }
}

extension Point: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return Point(x: self.x, y: self.y)
    }
}

var p1 = Point(x: 2, y: 3)
var p2 = p1.copy() as! Point
print(p1)
print(p2)