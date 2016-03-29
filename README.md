# SwiftPlayground
Playground で遊んだものたち  
Gist にも。

## Range
自作の型を要素に持つ Range を作って、マッチングも出来るようにしようとして、プロトコルのジェネリクスの絡んだすごいものを見た。

## Loop
ループする空間を作ってみた。趣旨としては、プロトコルの継承ってどういうことかを掴みたかった。

## LoopIndex
ループする Index の概念を作ってみた。Loop の書き換え。  
おまけで 5...2 とか作れるようにしてみた。

## methodAcceptSelf
```<# type #>.<# instance method #>(<# instance #>)``` の挙動を見てみた。  
検証してみたら、これは instance の参照を持つみたい。これは動作的に妥当な気がするけど、ちょっと謎な挙動をする場合があった。(詳細はコードの下の方のコメント)

```swift:sample
let myStruct = MyStruct()
MyStruct.mySimpleFunc(myStruct)     // () -> String
MyStruct.mySimpleFunc(myStruct)()   // "mySimpleFunc()"
```

## as
複数種類の型のオブジェクトが入っている AnyObject の配列から特定の型のオブジェクトだけの配列を作る + 配列の要素はキャストしておきたい。  
二つのアプローチ。

## colleciton
Set の挙動を見てみた。class 入れるともしかしたら危ないかなと思った。

## noescape
本当に生存期間が短いと保証してくれるのか、あれこれ試して満足した。信じることに。

## CSwift (カジュアル Swift 勉強会)
struct に class 型のプロパティを持つとどうなるか

## Delegate
Implicitly unwrapped optional にするとどうなるか

## MyPlayground
required 不要になる場合

## UIKitDynamics
結局、違うこと試してて、カオス

## extension
protocol のメソッド・関数を準拠した型の sub type でまだ上書きできない。(not yet)

## typealias
型を隠蔽できる
