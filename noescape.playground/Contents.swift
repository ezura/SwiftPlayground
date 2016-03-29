//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class MyClass {
    var closure : (() -> ())?
    func doAfter (@noescape closure : () -> ()) {
        // error: invalid conversion from non-escaping function of type '@noescape () -> ()' to potentially escaping function type '() -> ()'
//        self.closure = closure
    }
}

let numbers = [1, 2]
let copyNumbers = numbers
