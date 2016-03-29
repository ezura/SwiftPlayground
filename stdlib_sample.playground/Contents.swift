import Foundation

/*:
 ### SequenceType と Comparable
 */

let numbers = [2, 5, 1]
numbers.sort() // [1, 2, 5]

enum CupSize: Int {
    case Short = 0, Tall, Grande, Venti
}

// --- Comparable に準拠
extension CupSize : Comparable {}
// >, >=, <= は < と == が定義されていれば表現可能なのでここでは定義しなくて大丈夫
func <(lhs: CupSize, rhs: CupSize) -> Bool {
    return lhs.rawValue < rhs.rawValue
}
/* func ==<T : RawRepresentable where T.RawValue : Equatable>(lhs: T, rhs: T) -> Bool
   があるので、今回の場合、 == は自分で定義しなくても大丈夫
 */
//func ==(lhs: CupSize, rhs: CupSize) -> Bool
// ---

/*
 実際にソートしてみる
 配列の要素が Comparable に準拠していると下記の形で使える ("比較可能" なら現実世界で考えても、ソートできる)
 */
let cupSizes: [CupSize] = [.Short, .Grande, .Short]
cupSizes.sort()  // [Short, Short, Grande]


/*:
 Try
 
 * Comparable に準拠している箇所をコメントアウトしてみる。cupSizes.sort() はできるでしょうか。
 * func <(lhs: CupSize, rhs: CupSize) -> Bool のコメントアウトを外してみる (比較演算子が定義され、>, >=, <=, <, == が使える状態になりましたが、 cupSizes.sort() はできるでしょうか)
 */



/*:
 ### Range, ForwardIndex, Comparable, マッチング(~=) の働きかけ
 */
/*:
 やっていること
 1. Range の要素になれる自作の型を作る
 1. その型を要素に持つ Range でマッチングできるようにする
 */

// --- start: Range の要素にしたい型を定義 ---
struct MyForwardIndexTypeStruct {
    var num: Int
    init(_ num: Int) {
        self.num = num
    }
}

// ForwardIndexType に準拠するには _Incrementable に準拠することが必要
extension MyForwardIndexTypeStruct : ForwardIndexType {
    // _Incrementable
    func successor() -> MyForwardIndexTypeStruct {
        return MyForwardIndexTypeStruct(self.num+1)
    }
}
// _Incrementable は Equatable も内包
func == (lhs: MyForwardIndexTypeStruct, rhs: MyForwardIndexTypeStruct) -> Bool {
    return lhs.num == rhs.num
}
// --- end: Range の要素にしたい型を定義 ---


// --- start: MyForwardIndexTypeStruct を要素とする Range をマッチング可能にする(switch でのマッチングを使用するには ~= が必要) ---
// 方法1: Comparable に準拠させる
extension MyForwardIndexTypeStruct : Comparable {}
func <(lhs: MyForwardIndexTypeStruct, rhs: MyForwardIndexTypeStruct) -> Bool {
    print("\(lhs.num) \(#function) \(rhs.num)")
    return lhs.num < rhs.num
}

// 方法2: MyForwardIndexTypeStruct に対して ~= を使えるようにする
func ~= (pattern: Range<MyForwardIndexTypeStruct>, value: MyForwardIndexTypeStruct) -> Bool {
    print(#function)
    return pattern.contains(value)
}
// --- end: MyForwardIndexTypeStruct を要素とする Range をマッチング可能にする ---

// --- 動かしてみる
// 要素に Comparable が定義されていたら、作られるときに妥当かどうか検査が走る(< が呼ばれる)
// 定義されていなかったら妥当性の検査はしないので、範囲の指定としておかしくても通ってしまう
let myRange: Range = MyForwardIndexTypeStruct(1) ..< MyForwardIndexTypeStruct(5)
//let myRangeTest = MyForwardIndexTypeStruct(5) ..< MyForwardIndexTypeStruct(1)

myRange ~= MyForwardIndexTypeStruct(1)

print("start")
switch MyForwardIndexTypeStruct(2) {
case myRange:
    print("match")
default:
    print("")
}

/*:
 Try
 * "方法1: Comparable に準拠させる" を消してみる (どのメソッド・関数が呼ばれているでしょうか)
 * "方法1: Comparable に準拠させる" を消してみるを復活させて
   "方法2: MyForwardIndexTypeStruct に対して ~= を使えるようにする" を消してみる (どのメソッド・関数が呼ばれているでしょうか)
 *
 */


/*:
 少し解説
 - Range の要素になれる自作の型を作りたい
   * ForwardIndexType に準拠
 - その Range でパターンマッチしたい
   * ~= 実装 -> Comparable に準拠するだけでも両方でも OK
   * Comparable も実装すると Range 作るときに妥当性の検査をする。実装しないと検査しない。
     * Range のイニシャライザで、要素が Comparable に準拠していたら適用されるメソッドに、与えられた要素から妥当な Range が作れるか検査する処理がある
     * これが、Comparable に準拠しているかいないかで動作が変わった理由
   * ~= 実装するとマッチングのときに ~= 使われて、実装しない場合は Comparable (不等号) が使われる？ これはちょっと違う
     * func ~=<I : ForwardIndexType where I : Comparable>(pattern: Range<I>, value: I) -> Bool
       が適応され、中で不等号が呼ばれている。つまりどちらも ~= が使われている。
   * func ~= (pattern: Range<MyForwardIndexTypeStruct>, value: MyForwardIndexTypeStruct) -> Bool で具体的に型を指定しているものが採用される
 
 
   謝辞  
   @es_kumagai さんに教えていただき、理解できました！感謝！
 */
