//: Playground - noun: a place where people can play

import UIKit

class Task {
    private var process: (()->())
    private var previousTask: Task?
    
    init(process: ()->()) {
        self.process = process
    }
    
    deinit {
        print("deinit")
    }
    
    func then(nextProcess: ()->()) -> Task {
        let nextTask = Task(process: nextProcess)
        nextTask.previousTask = self
        return nextTask
    }
    
    func run() {
        guard let previousTask = self.previousTask else {
            process()
            return
        }
        
        dispatch_sync(dispatch_get_global_queue(0, 0), {
            [unowned self] in
            previousTask.run()
            self.process()
        })
    }
}

do {
    let task = Task()
        {
            print("start")
        }
        .then(){
            print("1")
        }
        .then(){
            print("2")
        }
    task.run()
    sleep(10)
}

//protocol PA {
//    
//}
//
//protocol PQ : PA {
//    
//}
//
//
//
//
//protocol P {
//    
//    //	func test() -> String
//}
//
//class A : P {
//    
//    //	func test() -> String {
//    //
//    //		return "A"
//    //	}
//}
//
//class B : A {
//    
//}
//
//class C : B {
//    
//}
//
//extension P where Self : A {
//    
//    func test() -> String {
//        
//        return "A"
//    }
//}
//
//extension P where Self : B {
//    
//    func test() -> String {
//        
//        return "B"
//    }
//}
//
//let s = [A(), B(), C()]
//
//s.dynamicType
//
//let a: P = A()
//let b: P = B()
//let c: P = C()
//
//// NG (when not defined in P): Ambiguous reference to member 'test'
//a.test()
////b.test()
////c.test()
//
//
//print("DONE")
//
//
//// お別れした後に追記
//
//let objA: A = A()
//let objB: B = B()
//
//objA.test()	// -> "A"
//objB.test()	// -> "B"
