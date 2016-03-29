/*
* 当初の目的
 - Range の要素になれる自作の型を作りたい
  * ForwardIndexType に準拠
 - その Range でパターンマッチしたい
  * ~= 実装 -> Comparable に準拠するだけでも両方でも OK
    * Comparable も実装すると Range 作るときに妥当性の検査はいる。実装しないと検査しない。
      * ジェネリクスに関係。Range のイニシャライザのジェネリクスで、要素が Comparable に準拠していたら適用されるメソッドに、与えられた要素から妥当な Range が作れるか検査する処理が描かれている。
        * これが、Comparable に準拠しているかいないかで動作が変わった理由
    * ~= 実装するとマッチングのときに ~= 使われて、実装しない場合は Comparable (不等号) が使われる？ これはちょっと違う
      * func ~=<I : ForwardIndexType where I : Comparable>(pattern: Range<I>, value: I) -> Bool
        * これが適応され、中で不等号が呼ばれている。つまりどちらも ~= が使われている。
      * func ~= (pattern: Range<MyForwardIndexTypeStruct>, value: MyForwardIndexTypeStruct) -> Bool で具体的に型を指定しているものが勝つ？
        * 思えば、不等号も具体的に型指定してる？

* 当初、不思議に思ったこと
  - !!!: Comparable 準拠でもいいし、~= 実装でも良いって設計的に良いものなの？
  - Comparable 準拠と ~= 実装、両方でも問題ない
  - Comparable は == と < があれば実現できるけど > とかも普通に自分で定義できちゃう。矛盾した実装したら大変じゃないかな。冗長なことはできないようにした方が安心じゃないかな。
  - !!!: 表面上同じだけど、Comparable 準拠してるかどうかで内部の動作違う、大混乱＼( 'ω')／ それって良いの？

* 今思っていること
  - 混乱した原因の一端は、プロトコルやジェネリック関数で実装がどうなってるか準拠している型から見えないから
    * 見えないことは気にしなくていいこと？ちゃんと妥当性があるように実装しているなら確かに考えなくていい、気がする
    * 見えない、考えなくて良いことこそちゃんと性質を実装に落とし込めてる証拠なのかも
  - 複数の方法で処理を実現可能にできるってどうなのかな。
    * 矛盾させた実装をしてたらどうするというのは、そもそも考えなくていいのかも。
    * 今回の例で言うと、Comparable と ~=。それぞれの性質を体現する、妥当な動作をするように実装しているなら不整合が起きることはない。だからどっちを使っても良い。どっちもあっても問題ない。
  - 今回の私はプロトコルや機能を使う側の立場で見て大混乱した。実際どうなっているのかを見ると納得した。どれが必須の実装なのか明記して欲しいなとも思った。(Comparable は < と = だけとか)
  - では、自分が作って提供する側となったとき、混乱させないか。
  - "ある性質を表現するための実装をした" の積み重ねで世界を作ってる。今回の私のやろうとしていたことはその性質を利用したものであって、私のやろうとしたことを実現するためにこれらの性質ができたのではない。ある性質を実現するにあたって、その性質をしっかり表現する実装をしてればいい。閉じた世界。そこで完結しているのかも？
*/

struct MyForwardIndexTypeStruct {
    var num: Int
    init(_ num: Int) {
        self.num = num
    }
}

// Equatable
func == (lhs: MyForwardIndexTypeStruct, rhs: MyForwardIndexTypeStruct) -> Bool {
    return lhs.num == rhs.num
}

extension MyForwardIndexTypeStruct : ForwardIndexType {
    // _Incrementable
    func successor() -> MyForwardIndexTypeStruct {
        return MyForwardIndexTypeStruct(self.num+1)
    }
}


extension MyForwardIndexTypeStruct : Comparable {}
// == と < だけあれば他は実現可能。
func <(lhs: MyForwardIndexTypeStruct, rhs: MyForwardIndexTypeStruct) -> Bool {
    print("\(lhs.num) \(#function) \(rhs.num)")
    return lhs.num < rhs.num
}
//func <=(lhs: MyForwardIndexTypeStruct, rhs: MyForwardIndexTypeStruct) -> Bool {
//    print("\(lhs.num) \(#function) \(rhs.num)")
//    return lhs.num <= rhs.num
//}
//func >=(lhs: MyForwardIndexTypeStruct, rhs: MyForwardIndexTypeStruct) -> Bool {
//    print("\(lhs.num) \(#function) \(rhs.num)")
//    return lhs.num >= rhs.num
//}
//func >(lhs: MyForwardIndexTypeStruct, rhs: MyForwardIndexTypeStruct) -> Bool {
//    print("\(lhs.num) \(#function) \(rhs.num)")
//    return lhs.num > rhs.num
//}

// Comparable なくてもこっちだけでマッチング可能。
// Comparable あるときは ~= のジェネリクスが使われる
//   func ~=<I : ForwardIndexType where I : Comparable>(pattern: Range<I>, value: I) -> Bool
//func ~= (pattern: Range<MyForwardIndexTypeStruct>, value: MyForwardIndexTypeStruct) -> Bool {
//    print(#function)
//    return pattern.contains(value)
//}

let start = MyForwardIndexTypeStruct(1)
let end = MyForwardIndexTypeStruct(5)
// 要素に Comparable が定義されていたら、作られるときに妥当かどうか検査が走る(< が呼ばれる)
// 定義されていなかったら妥当性の検査はしないので、範囲の指定としておかしくても通ってしまう
let myRange: Range = start ..< end

myRange ~= start

print("start")
switch MyForwardIndexTypeStruct(2) {
case myRange:
    print("match")
default:
    print("")
}

struct BooleanTypeStruct : BooleanType {
    var boolValue: Bool { return true }
}

let booleanTypeStruct = BooleanTypeStruct()
if booleanTypeStruct {
    print(booleanTypeStruct)
}

/*
< <= > >= 定義時
1 <= 5
start
5 >= 1
2 >= 1
2 < 5
match
*/

/*
< 定義時
5 < 1
start
5 < 1
2 < 1
2 < 5
match
*/


class A {}
class B : A {}
let b = B()
let castB = b as A

let v = 1 as Double
