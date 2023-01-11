import Foundation

// See simple example and some words about copying in Point.swift
// to support deep copy all reference types that are used by a class
// also have to implement the NSCopying protocol
// when copying the Point class you have also to copy the shape variable.


class Shape {
    var type: String
    var size: Int

    init(type: String, size: Int) {
        self.type = type
        self.size = size
    }
}

extension Shape: CustomStringConvertible {
   var description: String {
        return "Shape (\(type), \(size))"
   } 
}

extension Shape: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return Shape(type: self.type, size: self.size)
    }
}


class Point {
    var x: Int
    var y: Int
    var shape: Shape

    init(x: Int, y: Int, shape: Shape) {
        self.x = x
        self.y = y
        self.shape = shape

    }
}

// use extensions here to keep the class code clean
extension Point: CustomStringConvertible {
    var description: String {
        return "Point (\(x), \(y), \(shape))"
    }
}

extension Point: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return Point(x: self.x, y: self.y, shape: self.shape.copy() as! Shape)
    }
}

var p1 = Point(x: 2, y: 3, shape: Shape(type: "circle", size: 20))
var p2 = p1.copy() as! Point

p2.x = 23
p2.y = 90
p2.shape.size = 42
p2.shape.type = "cross"
print(p1)
print(p2)