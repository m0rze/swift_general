import UIKit

enum EngineAction {
    case start
    case stop
}

enum Window{
    case frontLeft
    case frontRight
    case rearLeft
    case rearRight
}

enum WindowsAction{
    case open
    case close
}

struct MainCarOptions {
    var model: String
    var year: Int
    var windowsState: [Window : WindowsAction] = { () -> [Window : WindowsAction] in
        var windowsState = [Window : WindowsAction]()
        windowsState[.frontLeft] = WindowsAction.close
        windowsState[.frontRight] = WindowsAction.close
        windowsState[.rearLeft] = WindowsAction.close
        windowsState[.rearRight] = WindowsAction.close
        return windowsState
    }()
    var engineState: EngineAction = .stop
    
    init(model: String, year: Int){
        self.model = model
        self.year = year
    }
    
    func showWindowsState(){
        print("   Состояние окон:")
        for window in self.windowsState {
            switch window {
            case (.frontLeft, .close):
                print("     - водительское окно закрыто")
            case (.frontRight, .close):
                print("     - окно переднего пассажира закрыто")
            case (.rearLeft, .close):
                print("     - заднее левое окно закрыто")
            case (.rearRight, .close):
                print("     - заднее правое окно закрыто")
            case (.frontLeft, .open):
                print("     - водительское окно открыто")
            case (.frontRight, .open):
                print("     - окно переднего пассажира открыто")
            case (.rearLeft, .open):
                print("     - заднее левое окно открыто")
            case (.rearRight, .open):
                print("     - заднее правое окно открыто")
            }
        }
    }
    
    func showEngineState(){
        print("   Статус двигателя:")
        switch self.engineState {
        case .stop:
            print("     Двигатель остановлен")
        case .start:
            print("     Двигатель запущен")
        }
    }
    
}

struct SportCar {
    var icon: String = "🚗"
    var mainOptions = MainCarOptions(model: "", year: 0)
    var rearTrunkValue: Double
    var frontTrunkValue: Double = 0.0
    
    init(model: String, year: Int, rearTrunkValue: Double){
        self.mainOptions.model = model
        self.mainOptions.year = year
        self.rearTrunkValue = rearTrunkValue
    }
    
    mutating func openWindow(window: Window){
        self.mainOptions.windowsState[window] = .open
    }
    
    mutating func closeWindow(window: Window){
        self.mainOptions.windowsState[window] = .close
    }
    
    mutating func stopEngine(){
        self.mainOptions.engineState = .stop
    }
    
    mutating func startEngine(){
        self.mainOptions.engineState = .start
    }
    
    func whatAboutThisCar(){
        print("\(icon) Ваша машина \(self.mainOptions.model) \(self.mainOptions.year) года выпуска.")
        if self.rearTrunkValue < 300.0 {
            print("Багажник совсем маленький - \(self.rearTrunkValue) литров")
        } else {
            print("Багажник объемом \(self.rearTrunkValue) литров")
        }
        
        if frontTrunkValue == 0.0 {
            print("Переднего багажника нет, это вам не электромобиль")
        } else {
            print("Есть даже передний багажник объемом \(frontTrunkValue) литров")
        }
        
        self.mainOptions.showWindowsState()
        self.mainOptions.showEngineState()
        print("\n\n")
    }
}

struct TrunkCar {
    var icon: String = "🚚"
    var mainOptions = MainCarOptions(model: "", year: 0)
    var bigTrunkValue: Double
    var cargoValue: Double = 0.0
    
    init(model: String, year: Int, bigTrunkValue: Double){
        self.mainOptions.model = model
        self.mainOptions.year = year
        self.bigTrunkValue = bigTrunkValue
        self.mainOptions.windowsState[.rearLeft] = nil
        self.mainOptions.windowsState[.rearRight] = nil
    }
    
    mutating func addCargo(newCargo: Double){
        if self.cargoValue + newCargo > self.bigTrunkValue {
            print("Слишком много груза, убавьте \(String(format: "%.2f", self.cargoValue + newCargo - self.bigTrunkValue)) литра(ов)\n")
            return
        }
        self.cargoValue += newCargo
    }
    
    mutating func removeCargo(removedCargo: Double){
        if self.cargoValue - removedCargo < 0 {
            print("В кузове нет столько груза, там всего \(String(format: "%.2f", self.cargoValue)) литра(ов)\n")
            return
        }
        self.cargoValue -= removedCargo
    }
    
    mutating func openWindow(window: Window){
        if window == .rearLeft || window == .rearRight {
            print("Этих окон в грузовике нет\n")
            return
        }
        self.mainOptions.windowsState[window] = .open
    }
    
    mutating func closeWindow(window: Window){
        if window == .rearLeft || window == .rearRight {
            print("Этих окон в грузовике нет \n")
            return
        }
        self.mainOptions.windowsState[window] = .close
    }
    
    mutating func stopEngine(){
        self.mainOptions.engineState = .stop
    }
    
    mutating func startEngine(){
        self.mainOptions.engineState = .start
    }
    
    func whatAboutThisCar(){
        print("\(icon) Ваш грузовик \(self.mainOptions.model) \(self.mainOptions.year) года выпуска.")
        print("Объем кузова - \(String(format: "%.2f", self.bigTrunkValue) ) литров")
        print("Груза в кузове - \(String(format: "%.2f", self.cargoValue)) литров")
        self.mainOptions.showWindowsState()
        self.mainOptions.showEngineState()
        print("\n\n")
    }
}


var mazda = SportCar(model: "Mazda 6", year: 2019, rearTrunkValue: 256.8)
mazda.whatAboutThisCar()
mazda.openWindow(window: .frontLeft)
mazda.openWindow(window: .rearRight)
mazda.whatAboutThisCar()
mazda.closeWindow(window: .frontLeft)
mazda.startEngine()
mazda.whatAboutThisCar()

var tatra = TrunkCar(model: "Tatra", year: 1978, bigTrunkValue: 3912.00)
tatra.whatAboutThisCar()
tatra.openWindow(window: .rearLeft)
tatra.openWindow(window: .frontLeft)
tatra.startEngine()
tatra.whatAboutThisCar()
tatra.addCargo(newCargo: 376.98)
tatra.whatAboutThisCar()
tatra.addCargo(newCargo: 120.99)
tatra.whatAboutThisCar()
tatra.removeCargo(removedCargo: 1349.43)
tatra.removeCargo(removedCargo: 108.65)
tatra.whatAboutThisCar()
