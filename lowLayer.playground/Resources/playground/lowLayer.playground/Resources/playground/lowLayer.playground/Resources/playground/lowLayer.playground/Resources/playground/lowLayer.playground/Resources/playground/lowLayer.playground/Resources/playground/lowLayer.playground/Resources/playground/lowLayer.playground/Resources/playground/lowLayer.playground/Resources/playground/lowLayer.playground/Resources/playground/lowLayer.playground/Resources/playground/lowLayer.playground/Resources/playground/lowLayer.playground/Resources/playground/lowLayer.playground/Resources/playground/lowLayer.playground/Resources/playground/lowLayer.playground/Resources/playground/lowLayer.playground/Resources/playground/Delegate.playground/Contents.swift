class ActionDelegate {
    let member = "ActionDelegate"
}

class DelegateSampleClass {
    weak var delegate : ActionDelegate!
    init (delegate: ActionDelegate) {
        self.delegate = delegate
    }
    func notOptional() {
        delegate.member
    }
    
    func optional() {
        delegate?.member
    }
}

var delegate = ActionDelegate()
let sample = DelegateSampleClass(delegate: delegate)
sample.optional()
sample.notOptional()

delegate = ActionDelegate() // 新しいのいれて sample に渡した delegate の参照を減らす
sample.optional()
sample.notOptional() // atal error: unexpectedly found nil while unwrapping an Optional value
