import UIKit

// Первое задание

print(evenCheck(for: 4))

func evenCheck(for inDigit: Int) -> Bool {
    let check: Int = inDigit % 2
    if check == 0 {
        return true
    }
    return false
}

// Второе задание

print(remainCheck(for: 6, denominator: 3))

func remainCheck(for inDigit: Int, denominator: Int) -> Bool {
    let check: Int = inDigit % denominator
    if check == 0 {
        return true
    }
    return false
}


// Третье задание

var increasingArray: [Int] = []

increaseMy(array: &increasingArray, withCount: 100)
print(increasingArray)

func increaseMy(array inArr: inout [Int], withCount: Int) {
    for n in 0...withCount {
        inArr.append(n)
    }
}

// Четвертое задание

popCustomElements(inMyArray: &increasingArray, by: [2,3])

print(increasingArray)

func popCustomElements(inMyArray: inout [Int], by: [Int]){
    var i: Int = 0
    for _ in inMyArray {
        for byItem in by {
            if inMyArray[i] % byItem == 0 {
                inMyArray.remove(at: i)
                i -= 1
                break
            }
        }
        i += 1
    }
}

// Пятое задание

var myFibonacciArray: [Int] = []

appendFibonacci(inArray: &myFibonacciArray, inCount: 50)
print(myFibonacciArray)

func appendFibonacci(inArray: inout [Int], inCount: Int){
    for n in 0...inCount {
        if(n == 0) {
            inArray.append(0)
        } else if (n == 1){
            inArray.append(1)
        } else {
            inArray.append(inArray[n-1] + inArray[n-2])
        }
    }
}

// Шестое задание

var simpleNumsArray: [Int] = []

increaseMy(array: &simpleNumsArray, withCount: 100)
removeNonSimpleNums(inArray: &simpleNumsArray)
print(simpleNumsArray)

func removeNonSimpleNums(inArray numArray: inout [Int]){
    numArray.remove(at: 1)
    numArray.remove(at: 0)
    var tempArray: [Int] = numArray
    for k in numArray{
        for v in tempArray{
            if remainCheck(for: v, denominator: k) && k != v{
                numArray.remove(at: numArray.firstIndex(of: v)!)
            }
        }
        tempArray = numArray
        tempArray.removeLast()
    }
}

