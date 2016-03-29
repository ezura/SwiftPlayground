

// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    }
    else {
        teamScore += 1
    }
}
println(teamScore)


var optionalString: String? = "Hello"
println(optionalString == nil)

var optionalName:String? = "John"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}



let vegetable = "red pepper"
switch vegetable {
    case "celery":
        let vegetableComment = "Add some rains and make ants on a log."
    case "cucumber", "watercress":
        let vegetableComment = "TThat would meke a good tea sandewich."
    case let x where x.hasSuffix("pepper"):
        let vegetableCommnt = x
    default:
        let vegetableComment = "Everythig tests good in soup."
    
}


func greet(name: String, day: String) -> String {
    return "Hello \(name), today is \(day)"
}

greet("bob", "tuesday")


func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}

sumOf(1,2,3,4,5)
sumOf()


func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}

returnFifteen()


func makeIncrement() -> (Int -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    
    return addOne
}

var increment = makeIncrement()
increment(7)


func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}


var numbers = [1, 2, 3, 4]
hasAnyMatches(numbers, lessThanTen)

numbers.map({
    (number: Int) -> Int in
        let result = 2 * number
        return result
})

func double(number: Int) -> Int {
    let result = 2 * number
    return result
}

numbers.map(double)

var doublefunc = double
numbers.map(doublefunc)


var mappedNumber = numbers.map({ number in 2 * number })
mappedNumber

var num = sorted(numbers) { $0 > $1 }
num


class Shape {
    var numberOfSides = 0
    var className = "Shape"
    func simpleDescription() -> String {
        println(className)
        return "A shape with \(numberOfSides) sides."
    }
}

var shape = Shape()
shape.numberOfSides
var shapeDescription = shape.simpleDescription()
var varClassName = shape.className
shape.className = "shape?"
varClassName
shape.className

class NameShape {
    var numberofSides: Int = 0
    var name: String
    init () {
        self.name = "unknown"
    }
    
    init (name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shepe with \(numberofSides) sides."
    }
    
    deinit {
        println("deinit")
    }
}

var namedShape:NameShape? = NameShape()
namedShape = nil

numbers.map({
    (number:Int) -> Int in
        let result = 3 * number
    return result
})







