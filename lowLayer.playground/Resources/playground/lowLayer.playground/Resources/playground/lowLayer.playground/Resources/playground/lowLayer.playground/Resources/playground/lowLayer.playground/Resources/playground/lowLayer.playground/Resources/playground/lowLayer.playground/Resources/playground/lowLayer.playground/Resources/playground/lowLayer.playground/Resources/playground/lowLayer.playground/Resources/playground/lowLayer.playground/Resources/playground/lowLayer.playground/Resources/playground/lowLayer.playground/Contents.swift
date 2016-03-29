//: Playground - noun: a place where people can play

import Foundation
import ObjectiveC

// Swiftで生成したクラスにMethodSwizzlingをすると失敗するデモ
class A: NSObject {
    func zero() -> NSNumber {
        return 0
    }
    
    func one() -> NSNumber {
        return 1
    }
}

// 普通に呼び出してみる
var a = A()
a.zero()
a.one()

// objc_msgSend経由
a.performSelector("zero")
a.performSelector("one")

// MethodSwizzling
var m1 = class_getInstanceMethod(A.self, "zero")
var m2 = class_getInstanceMethod(A.self, "one")
method_exchangeImplementations(m1, m2)

// 普通に呼び出してみる (入れ替わっていない)
a.zero()
a.one()


// objc_msgSend経由 (入れ替わっている)
a.performSelector("zero")
a.performSelector("one")

// NSObjectでなければ、そもそもmethodが取得できない
class B {
    func zero() -> NSNumber {
        return 0
    }
}

var m3 = class_getInstanceMethod(B.self, "zero")



// private funcではmethodが取得できない
class C: NSObject {
    private func zero() -> NSNumber {
        return 0
    }
}

var m4 = class_getInstanceMethod(C.self, "zero")


// AnyにOptionalの値を与えると取り出せなくなる
var io: Int? = 1
var any: Any = io
var i = any as? Int
// i = any as? Optional<Int> 出来ない

// 一応、Mirrorを使えば取り出すことは可能(割愛しました)
var mirror = Mirror(reflecting: any)
i = mirror.children.first?.value as? Int


// Methodをクロージャとして渡すと、キャプチャされてReferenceCountingが増えるデモ
class D {
    var closure: () -> () = { }
    func run() {
        self.closure()
    }
}

class E {
    func function() {
        // eにnilを代入しても呼ばれてしまう
        1
    }
}

var d = D()
var e: E? = E()
d.run()
d.closure = e!.function
d.run()
e = nil
// eがキャプチャされているため、dが消えるまでeも消えない
d.run()

// そもそもSwiftのクロージャに対する変数のキャプチャの仕様が微妙
//

// ProtocolExtensionを実装したクラスのメソッドで上書きした場合の挙動
protocol P {
    func num() -> Int
}

extension P {
    // デフォルトメソッドを定義
    func num() -> Int {
        return 0
    }
}

class F: P {
    func num() -> Int {
        return 1
    }
}

class G: F {
    override func num() -> Int {
        return 2
    }
}

// 上書きしたメソッドが呼ばれる
F().num()
G().num()

// Pにキャストしても同様
(F() as P).num()
(G() as P).num()

// メソッドを上書きしないクラスを継承した場合
class H: P {
    
}

class I: H {
    func num() -> Int {
        return 2
    }
}

// 上書きしたメソッドが呼ばれる
H().num()
I().num()

// Pにキャストした場合、上書きしたメソッドが呼ばれない
(H() as P).num()
(I() as P).num()


let a = 1
a.0
