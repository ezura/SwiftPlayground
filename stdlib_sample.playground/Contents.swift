//: Playground - noun: a place where people can play

import Foundation

let array: Array = [1, 2, 3]
array.forEach { print($0) }
_ = array.map { $0*2 }

protocol A {
}

extension A {
    func sample()
}

