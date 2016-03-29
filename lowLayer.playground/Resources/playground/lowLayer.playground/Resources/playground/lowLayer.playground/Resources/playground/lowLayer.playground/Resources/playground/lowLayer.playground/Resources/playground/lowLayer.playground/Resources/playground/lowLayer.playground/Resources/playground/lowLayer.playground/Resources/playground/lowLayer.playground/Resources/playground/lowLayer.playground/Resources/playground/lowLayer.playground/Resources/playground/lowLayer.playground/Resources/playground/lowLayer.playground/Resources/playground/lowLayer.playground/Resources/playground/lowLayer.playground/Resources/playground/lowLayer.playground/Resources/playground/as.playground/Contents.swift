//: Playground - noun: a place where people can play

import UIKit

//let funcObj : Any = {(obj : Any) -> String in "aa"}
//
//switch funcObj {
//case let obj as (String) -> String:
//    print(obj("aaa"))
//}

/*
複数種類の型のオブジェクトが入っている AnyObject の配列から
特定の型のオブジェクトだけの配列を作る + 配列の要素はキャストしておきたい
*/

class MyClass {}
class Dummy {}

let anyObjArray : [AnyObject] = [MyClass(), MyClass(), Dummy()]
print(anyObjArray.dynamicType)    // Array<AnyObject>

let myClassArray1 = anyObjArray.filter{ return $0 is MyClass }.map{ $0 as! MyClass }
print(myClassArray1.dynamicType)  // Array<MyClass>

let myClassArray2 = anyObjArray.filter{ return $0 is MyClass } as! Array<MyClass>
print(myClassArray2.dynamicType)  // Array<MyClass>


/*
今日のお話ででてきた、「AnyObject の配列から特定の型だけのオブジェクトの配列を作る(配列の要素はキャストしておきたい)」がおもしろかった。
myClassArray1 と myClassArray2 は違うアプローチで目的を達成してる。
*/