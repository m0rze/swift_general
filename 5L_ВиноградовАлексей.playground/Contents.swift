import Foundation
import UIKit

enum Windows {
    case open, close
}

enum Engine {
    case on, off
}

enum Colors: String {
    
    case black = "черный"
    case white = "белый"
    case blue = "синий"
    case yellow = "желтый"
    case red = "красный"
    
}

protocol Car {
    
    var model: String {get}
    var year: Int {get}
    var color: Colors {get set}
    var engineState: Engine {get set}
    
    var windowsState: Windows {get set}
    
    mutating func pushEngineButton()
    mutating func windowsAction()
    mutating func changeColor(to newColor: Colors)
    
    init(model: String, year: Int, color: Colors)
}

class MainCarData: Car {
    
    var model: String
    
    var year: Int
    
    var color: Colors
    
    var engineState: Engine = .off
    
    var windowsState: Windows = .close
    
    required init(model: String, year: Int, color: Colors) {
        self.model = model
        self.year = year
        self.color = color
    }
    
}

class SportCar: MainCarData {
    
    var maxSpeed: Int
    
    init(model: String, year: Int, color: Colors, maxSpeed: Int) {
        self.maxSpeed = maxSpeed
        super.init(model: model, year: year, color: color)
    }
    
    required init(model: String, year: Int, color: Colors) {
        fatalError("init(model:year:color:) has not been implemented")
    }
    
}

class TrunkCar: MainCarData {
    
    enum Cities: String {
        case moscow = "Москва"
        case sochi  = "Сочи"
        case piter = "Санкт-Петербург"
        case kazan = "Казань"
        case tumen = "Тюмень"
    }
    
    var allCargoValue: Double
    var currentCargoValue: Double = 0.0
    
    var gpsTrack: [Cities] = []
    
    init(model: String, year: Int, color: Colors, allCargoValue: Double) {
        self.allCargoValue = allCargoValue
        super.init(model: model, year: year, color: color)
    }
    
    required init(model: String, year: Int, color: Colors) {
        fatalError("init(model:year:color:) has not been implemented")
    }
    
    func addCargo(newCargo: Double) {
        switch newCargo {
        case let newCargo where newCargo + self.currentCargoValue < self.allCargoValue:
            print("В кузов добавлено \(newCargo) тонн груза")
            self.currentCargoValue += newCargo
        case let newCargo where newCargo + self.currentCargoValue > self.allCargoValue:
            print("Слишком много нового груза, не влезет")
        default:
            self.currentCargoValue += newCargo
            print("Груз вместился, кузов теперь полон")
            
        }
    }
    
    func removeCargo(value: Double){
        
        switch value {
        case let value where self.currentCargoValue - value < 0:
            print("Столько груза нет в кузове, по внимательнее с цифрами")
        default:
            self.currentCargoValue -= value
            print("Груза подубавилось")
        }
    }
    
    func addGPSPoint(to point: Cities){
        self.gpsTrack.append(point)
    }
    
    func whereAreWeGoing(){
        if self.gpsTrack.count == 0 {
            print("Маршрут не задан")
            return
        }
        var gpsCityNames: String = ""
        var i = 0
        for oneCity in gpsTrack {
            if i == gpsTrack.count - 1 {
                gpsCityNames += "\(oneCity.rawValue)"
            } else {
                gpsCityNames += "\(oneCity.rawValue)-"
            }
            
            i += 1
        }
        print("Наш путь пролегает по следующим городам: \(gpsCityNames)")
        
    }
    
}

extension Car {
    mutating func pushEngineButton() {
        switch self.engineState {
        case .off:
            self.engineState = .on
            print("Запустили двигатель")
        case .on:
            self.engineState = .off
            print("Выключили двигатель")
        }
    }
    
    mutating func windowsAction() {
        switch self.windowsState {
        case .open:
            self.windowsState = .close
            print("Закрыли окна")
        case .close:
            self.windowsState = .open
            print("Открыли окна")
        }
    }
    
    mutating func changeColor(to newColor: Colors) {
        self.color = newColor
        print("Перекрашено в \(newColor.rawValue) цвет")
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return("\n🏎 Автомобиль \(model) \(year) года выпуска, максимальная скорость \(maxSpeed) км/ч, цвет \(color.rawValue)\n")
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        var icon: String = "🛻"
        if currentCargoValue > 0.0 {
            icon = "🚚"
        }
        return("\n\(icon) Грузовик \(model) \(year) года выпуска, грузоподьемностью \(allCargoValue) тонн, цвет \(color.rawValue)\n")
    }
}

// ==========================================================================

var mazda = SportCar(model: "Mazda", year: 2019, color: .blue, maxSpeed: 220)
print(mazda)
mazda.pushEngineButton()
mazda.windowsAction()
mazda.windowsAction()
mazda.pushEngineButton()
mazda.changeColor(to: .yellow)
print(mazda)


var tatra = TrunkCar(model: "Tatra", year: 1978, color: .yellow, allCargoValue: 100.0)
print(tatra)
tatra.windowsAction()
tatra.pushEngineButton()
tatra.addCargo(newCargo: 98.8)
tatra.changeColor(to: .red)
print(tatra)
tatra.addGPSPoint(to: .moscow)
tatra.addGPSPoint(to: .sochi)
tatra.addGPSPoint(to: .tumen)
tatra.whereAreWeGoing()
