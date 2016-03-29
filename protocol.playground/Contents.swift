protocol AddAble {
    func +(lhs: Self, rhs: Self) -> Self
}

func addThreeTuple<T> where T : AddAble {
    
}

extension Int : AddAble, TripleTupleAdable {
}


Int.addThreeTuple((1, 1, 1), t2: (2, 2, 2), t3: (3, 3, 3))
(1, 2, 3).dynamicType