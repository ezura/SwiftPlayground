// ある空間上でループするインデックスが持つ性質
protocol LoopIndexible : ForwardIndexType {
    typealias RawIndex : Equatable, _Incrementable
    static var minIndex : RawIndex { get }
    static var maxIndex : RawIndex { get }
    
    var rawIndex: RawIndex { get set }
    init(_ rawIndex: RawIndex)
}

extension LoopIndexible {
    func successor() -> Self {
        if(self.rawIndex == Self.maxIndex) {
            return Self(Self.minIndex)
        }
        return Self(self.rawIndex.successor())
    }
}


// 実際に LoopIndexible に準拠した型定義
struct LoopIndex : LoopIndexible {
    static let minIndex = 0
    static let maxIndex = 10
    
    var rawIndex: Int
    
    init(_ rawIndex: Int) {
        // 本当は値制限しないといけないけど省略
        self.rawIndex = rawIndex
    }
}
func == (lhs: LoopIndex, rhs: LoopIndex) -> Bool {
    return lhs.rawIndex == rhs.rawIndex
}

// LoopIndex をパターンマッチできるようにする
func ~= (pattern: Range<LoopIndex>, value: LoopIndex) -> Bool {
    return pattern.contains(value)
}

// 良い感じに書くためのおまけ
extension LoopIndex : IntegerLiteralConvertible {
    init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}

// テスト
var loop: LoopIndex = 7
// 7        -> 8        -> 9       -> 10        -> 0        -> 1
loop.successor().successor().successor().successor().successor().rawIndex  // -> 1

let loopRange : Range<LoopIndex> = 5...2
loopRange ~= 1  // true
switch LoopIndex(3) {
case loopRange:
    print(loopRange)
default:
    print("default")
}

//typealias Config = (param1: Int, param2: String)
//var config: Config = (1, "")
//func myFunc(config: Config) {
//    print(__FUNCTION__)
//}
//
//config.param1 = 2
//config
//
//myFunc(config)
//
//func returnIntFunc() -> Int {
//    print("returnInt")
//    return 1
//}
//
//func sample() -> Int {
//    return
//    returnIntFunc()
//    print("after return")
//    returnIntFunc()
//}
//
//sample()  // after return が出力
//
//import Foundation

//enum JsonElement {
//    case String(Swift.String)
//    case Bool(Swift.Bool)
//    case Number(NSNumber)
//    case
//}
//
//let a = print("")
//a
//
//struct Json {
//}
//
//
//
//class MyClass {
//    var number: Int = 0
//    lazy var a: () -> () = self.handler()
//    
//    func handler() -> (() -> ()) {
//        return {
//            self.number++
//        }
//    }
//    
//    deinit {
//        print("deinit")
//    }
//}
//
//do {
//  let myClass = MyClass()
//  myClass.a  // lazy var a が "self が使われてるクロージャ" を保持するので解放されなくなる
//}
