//: Playground - noun: a place where people can play

import UIKit

let a = [Int](count: 3, repeatedValue: 2)

// Set
// リテラルで作る場合

// 入れられないところに insert する
a[1]
// a[5]  // bad access

for (index, value) in a.enumerate() {
    
}

1.hashValue


// hashValue の値で同一性を判断するクラス
class MyClass : Hashable {
     var hashValue: Int = 1
    init(_ hashValue: Int) {
        self.hashValue = hashValue
    }
}
func ==(lhs: MyClass, rhs: MyClass) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

let myClassA2 = MyClass(2)
var set: Set<MyClass> = [MyClass(1), MyClass(1), myClassA2] // {{hashValue 2}, {hashValue 1}}
myClassA2.hashValue = 1
set // {{hashValue 1}, {hashValue 1}}
set.insert(MyClass(1)) // {{hashValue 1}, {hashValue 1}}
set.insert(MyClass(2)) // {{hashValue 1}, {hashValue 2}, {hashValue 1}}


//for elem in a {}
////a.forEach(<#T##body: (Int) throws -> ()##(Int) throws -> ()#>)
//a.forEach(<#T##body: (Int) throws -> ()##(Int) throws -> ()#>)
//a.sort()

var dict = [10: 1, 9: 2, 8: 3]
let sortDict = dict.sort { $0.0 < $1.1 }
sortDict  // [(.0 9, .1 2), (.0 10, .1 1), (.0 8, .1 3)]