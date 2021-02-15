import UIKit

// Первое задание. Квадратное уравнение вида ax2 + bx + c = 0
print("======== Первое задание ========")
let a: Double = -1
let b: Double = -2
let c: Double = 15
print("Квадратное уравнение: \(Int(a))x2 + \(Int(b))x + \(Int(c)) = 0")
let d: Double = b * b - 4 * a * c // Вычисляем дискриминант

print("Дискриминант D = \(Int(d))")

switch d {
case _ where d < 0 :
    print("Дискриминант меньше нуля- действительных корней нет")
case _ where d == 0 :
    let xOne: Double = ( -b + sqrt(d)) / (2 * a)
    print("Дискриминант равен нулю.")
    print("Корень всего один: x = \(Int(xOne))")
default :
    let xOne: Double = ( -b + sqrt(d)) / (2 * a)
    let xTwo: Double = ( -b - sqrt(d)) / (2 * a)
    print("Дискриминант больше нуля.")
    print("Первый корень: x1 = \(Int(xOne))")
    print("Второй корень: x2 = \(Int(xTwo))")
}

// Второе задание.
print("\n\n======== Второе задание ========")
let katetOne: Double = 3
let katetTwo: Double = 4

print("Площадь прямоугольного треугольника: \(katetOne * katetTwo / 2)")
print("Гипотенуза: \(sqrt(katetOne * katetOne + katetTwo * katetTwo))")
print("Периметр прямоугольного треугольника: \(katetOne + katetTwo + sqrt(katetOne * katetOne + katetTwo * katetTwo))")

// Третье задание.
print("\n\n======== Третье задание ========")

myMoney(inMoney: 5000.70, percent: 10.8)

func myMoney(inMoney: Double, percent: Double){
    
    var inMoney = inMoney
    var yearly: Double = 0
    print("Ваш вклад \(inMoney) на 5 лет под \(percent)%")
    yearly = inMoney * percent / 100
    inMoney = yearly + inMoney
    print("Через год: \(Float(inMoney))")
    yearly = inMoney * percent / 100
    inMoney = yearly + inMoney
    print("Через 2 года: \(Float(inMoney))")
    yearly = inMoney * percent / 100
    inMoney = yearly + inMoney
    print("Через 3 года: \(Float(inMoney))")
    yearly = inMoney * percent / 100
    inMoney = yearly + inMoney
    print("Через 4 года: \(Float(inMoney))")
    yearly = inMoney * percent / 100
    inMoney = yearly + inMoney
    print("Через 5 лет: \(Float(inMoney))")
    
}
