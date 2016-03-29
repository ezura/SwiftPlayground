//: Playground - noun: a place where people can play

import UIKit

struct MySequenceTypeStruct {}

extension MySequenceTypeStruct: SequenceType {
    func generate() -> AnyGenerator<Int> {
        var iteration = 0
        return AnyGenerator {
            defer {
                iteration += 1
            }
            
            guard iteration > 3 else {
                return iteration
            }
            return nil
        }
    }
}
1 ... 3
let array = [1, 2, 3]
for element in array {
    print(element)
    for element in array {
        print("nest \(element)")
    }
    break
}

print()
if true { /* do something */ }

//let array: Array = [1, 2, 3]
for element in array { /* do something */ }
array.forEach { _ in /* do something */ }
array.sort(<)
array.count // CollectionType
[1, 2, 3].count

print("--- sequenceTypeStruct ---")
let sequenceTypeStruct = MySequenceTypeStruct()
for element in sequenceTypeStruct {
    print(element)
    for element in sequenceTypeStruct {
        print("nest \(element)")
    }
    if element == 2 {
        break
    }
}

for element in sequenceTypeStruct {
    print(element)
}

sequenceTypeStruct.sort(>)
sequenceTypeStruct.underestimateCount()
sequenceTypeStruct.prefix(3)
sequenceTypeStruct.dropFirst().forEach { print($0) }

//sequenceTypetruct.count

//Self.Generator.Element = Int
//struct Int : Comparable
//
//protocol SequenceType {
//    associatedtype Generator : GeneratorType
//    public func generate() -> Self.Generator
//    public func forEach(@noescape body: (Self.Generator.Element) throws -> Void) rethrows
//}
//
//extension SequenceType where Self.Generator.Element : Comparable {
//    public func sort() -> [Self.Generator.Element]
//}


enum CupSize: Int {
    case Short = 0, Tall, Grande, Venti
}

extension CupSize : Comparable {}
func ==(lhs: CupSize, rhs: CupSize) -> Bool {
    return lhs.rawValue == rhs.rawValue
}
func <(lhs: CupSize, rhs: CupSize) -> Bool {
    return lhs.rawValue < rhs.rawValue
}
let cupSizes: [CupSize] = [.Short, .Grande, .Short]
cupSizes.sort(<)  // Self.Generator.Element が Comparable に準拠してる場合に使えるようになる
// [Short, Short, Grande]
//NSFastEnumeration
//NSEnumerator

struct MySequenceTypeStruct2 {}

extension MySequenceTypeStruct2: SequenceType {
    func generate() -> AnyGenerator<CupSize> {
        var iteration = 0
        return AnyGenerator {
            defer {
                iteration += 1
            }
            
            guard iteration > 3 else {
                return .Short
            }
            return nil
        }
    }
}

