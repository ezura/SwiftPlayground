struct LoopIndex {
    private static let MIN_INDEX = 1
    private static let MAX_INDEX = 8
    let index : Int!
    init(_ index: Int) {
        // 本当は値制限しないといけないけど省略
        guard case LoopIndex.MIN_INDEX ..< LoopIndex.MAX_INDEX = index else {
            
            fatalError()
        }
        
        self.index = index
    }
}

protocol EmptyInitialable {
    
    init()
}

protocol Indicesable {

    static var startIndex: Int { get }
    static var endIndex: Int { get }
}

protocol IntegerInitializable {
    
    init(_ value: Int)
}

extension String : EmptyInitialable {
    
}

extension LoopIndex {
    
    static var length: Int {
        
        return LoopIndex.MIN_INDEX.distanceTo(LoopIndex.MAX_INDEX)
    }
    
    private init(indexStartByZero index: Int) {
        
        self.index = index + LoopIndex.MIN_INDEX
    }
}

extension LoopIndex : Indicesable {
    
    static var startIndex: Int {
        
        return LoopIndex.MIN_INDEX
    }
    
    static var endIndex: Int {
        
        return LoopIndex.MAX_INDEX
    }
}

extension Indicesable where Self : IntegerInitializable {
    
    var STARTINDEX : Indicesable {
        
        return IntegerInitializable(Indicesable.startIndex)
    }
}

extension LoopIndex : IntegerInitializable {
    
}

func == (lhs: LoopIndex, rhs: LoopIndex) -> Bool {
    return lhs.index == rhs.index
}

extension LoopIndex : ForwardIndexType {
    func successor() -> LoopIndex {
        let newIndex = (index+1 < self.dynamicType.MAX_INDEX) ? index+1 : self.dynamicType.MIN_INDEX
        print(__FUNCTION__)
        return LoopIndex(newIndex)
    }
}

// パターンマッチ用
func ~= (pattern: Range<LoopIndex>, value: LoopIndex) -> Bool {
    return pattern.contains(value)
}

let loopRange = LoopIndex(5) ... LoopIndex(2)
print("start")
loopRange ~= LoopIndex(2)
print("end")

struct FixedArray<T : EmptyInitialable, I : ForwardIndexType where I : Indicesable, I : IntegerInitializable, I.Distance == Int> : CollectionType, MutableCollectionType {
    
    private var currentIndex: I
    private var elements: [T]
    
    init() {
        
        self.elements = Array<T>(count: LoopIndex.length, repeatedValue: T())
        self.currentIndex = I(I.startIndex)
    }
    
    var startIndex: I {
        
        return I(elements.startIndex + I.startIndex)
    }
    
    var endIndex: I {
        
        return I(elements.endIndex + I.startIndex)
    }
    
    mutating func append(element: T) {
        
        defer {
            currentIndex = currentIndex.successor()
        }

        elements[I(I.startIndex).distanceTo(currentIndex)] = element
    }
    
    subscript (index: I) -> T {
        
        get {
            return elements[I(I.startIndex).distanceTo(index)]
        }
        
        set {
            elements[I(I.startIndex).distanceTo(index)] = newValue
        }
    }
}

extension FixedArray : CustomStringConvertible {
    
    var description: String {
        
        return elements.description
    }
}

//extension LoopArray : CustomPlaygroundQuickLookable {
//    
//    func customPlaygroundQuickLook() -> PlaygroundQuickLook {
//
//        PlaygroundQuickLook.
//    }
//}

var loopArray = FixedArray<String, LoopIndex>()


var lineNumber = 1

loopArray.append("LINE \(lineNumber++)")
loopArray.append("LINE \(lineNumber++)")
loopArray.append("LINE \(lineNumber++)")
loopArray.append("LINE \(lineNumber++)")
loopArray.append("LINE \(lineNumber++)")
loopArray.append("LINE \(lineNumber++)")
loopArray.append("LINE \(lineNumber++)")
loopArray.append("LINE \(lineNumber++)")

LoopIndex.length

loopArray


