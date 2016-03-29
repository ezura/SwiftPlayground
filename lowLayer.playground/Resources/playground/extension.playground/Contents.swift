//: Playground - noun: a place where people can play

import UIKit
import XCTest
protocol MyProtocol {
    func protocolFunc() -> String
}

//class MyClass {}
class MyClass : MyProtocol {
    func protocolFunc() -> String {
        return "\(self)"
    }
}

extension MyClass {
    var a = 1
}

class MyChildClass : MyClass {
    // error: declarations from extensions cannot be overridden yet
    override func protocolFunc() -> String {
        return "override"
    }
}

let parent = MyClass()
let child = MyChildClass()

parent.protocolFunc()
child.protocolFunc()