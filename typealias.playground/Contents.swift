//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol MyProtocol {
    typealias Element
    var element : Element { get set }
}

struct MyStruct : MyProtocol {
    var element : Int
}

struct Sample {
    func sampleFunc() -> MyStruct {
        // MyProtocol で宣言している Element を MyStruct が具体的に何型に定義しているか気にしなくても良い
        return MyStruct(element: MyStruct.Element(1.0))
    }
}
