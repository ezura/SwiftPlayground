protocol HogeProtocol {
    init(name: String)
}

class HogeClass : HogeProtocol {
    required init(name: String) { // HogeProtocol の init(name: String) 必須
    }
}
class Hige : HogeClass {
    required init(name: String) { // // HogeProtocol の init(name: String) 必須
        super.init(name: name)
    }
}

final class FinalClass : HogeProtocol {
    init(name: String) { // final あるから継承できない ->  required 不要
    }
}
