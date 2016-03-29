//protocol MyProtocol {
//    typealias T
//    func method1() -> T
//}
//
//extension MyProtocol {
//    func method1() -> String {
//        return "protocol (1)"
//    }
//    
//    func method2() -> String {
//        return "protocol (2)"
//    }
//}
//
//struct MyStruct: MyProtocol {
//    func method1() -> String {
//        return "struct (1)"
//    }
//}
//
//let a = MyStruct()
//a.method1()  // struct (1)
//a.method2()  // protocol (2)

class MyClass {
    var a = 1
}

struct MyStruct {
    var myClass = MyClass()
    var int
}

let myStruct1 = MyStruct()
let myStruct2 = myStruct1

myStruct1.myClass.a
myStruct1.int = 1

myStruct.myClass.a = 2

myStruct.myClass.a




