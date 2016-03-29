//: Playground - noun: a place where people can play

import UIKit

struct MyStruct {
    func mySimpleFunc() -> String {
        return #function
    }
    
    func my1ParamFunc(param: Int) -> String {
        return #function
    }
    
    func my2ParamFunc(param1: Int, _ param2: Int) -> String {
        return #function
    }
}

let myStruct = MyStruct()
MyStruct.mySimpleFunc(myStruct)     // () -> String
MyStruct.mySimpleFunc(myStruct)()   // "mySimpleFunc()"

MyStruct.my1ParamFunc(myStruct)     // Int -> String
MyStruct.my1ParamFunc(myStruct)(1)  // "my1ParamFunc"

MyStruct.my2ParamFunc(myStruct)        // (Int, Int) -> String
MyStruct.my2ParamFunc(myStruct)(1, 1)  // "my2ParamFunc"


class MyClass {
    func mySimpleFunc() -> String {
        return #function
    }
    
    func my1ParamFunc(param: Int) -> String {
        return #function
    }
    
    func my2ParamFunc(param1: Int, _ param2: Int) -> String {
        return #function
    }
    
    deinit {
        print("deinit")
    }
}

do {
    var myClass = MyClass()
    MyClass.mySimpleFunc(myClass)     // () -> String
    MyClass.mySimpleFunc(myClass)()   // "mySimpleFunc()"
    
//    var closure: ((Int, Int) -> String)? = MyClass.my2ParamFunc(myClass)
//    closure = nil
    print("before replece myClass")
    myClass = MyClass()
    print("after replece myClass")
}

/*
 MyClass.my*Func を使わない場合、変数から参照なくなると解放
 before replece myClass
 deinit
 after replece myClass
 deinit
 */

/*
  MyClass.my*Func を使うと、変数からの参照なくなっても解放されない？
 before replece myClass
 after replece myClass
 deinit
 deinit
 */

/*
 MyClass.my*Func の返り値を変数に入れて、それを解放すると
 変数から参照なくなると解放になる
 before replece myClass
 deinit
 after replece myClass
 deinit
 */
