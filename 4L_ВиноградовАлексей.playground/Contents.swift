import UIKit

class MainCarOptions {
    
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


class SportCar: MainCarOptions {
    var icon: String = "🚗"
    var rearTrunkValue: Double?
    var frontTrunkValue: Double = 0.0
    
    
    init(model: String, year: Int, rearTrunkValue: Double){
        super.init(model: model, year: year)
        self.rearTrunkValue = rearTrunkValue
    }
    
    func openWindow(window: Window){
        self.windowsState[window] = .open
    }
    
    func closeWindow(window: Window){
        self.windowsState[window] = .close
    }
    
    func stopEngine(){
        self.engineState = .stop
    }
    
    func startEngine(){
        self.engineState = .start
    }
    
    func whatAboutThisCar(){
        print("\(icon) Ваша машина \(self.model) \(self.year) года выпуска.")
        guard let rearTrunkValue = self.rearTrunkValue else {return}
        if rearTrunkValue < 300.0 {
            print("Багажник совсем маленький - \(rearTrunkValue) литров")
        } else {
            print("Багажник объемом \(rearTrunkValue) литров")
        }
        
        if frontTrunkValue == 0.0 {
            print("Переднего багажника нет, это вам не электромобиль")
        } else {
            print("Есть даже передний багажник объемом \(frontTrunkValue) литров")
        }
        
        self.showWindowsState()
        self.showEngineState()
        print("\n\n")
    }
}


class TrunkCar: MainCarOptions {
    
    enum trunkStatus: String {
        case open = "\nКузов открыт для загрузки"
        case close = "Кузов закрыт\n"
    }
    
    var icon: String = "🚚"
    var bigTrunkValue: Double?
    var cargoValue: Double = 0.0
    var trunkStatus: trunkStatus = .close
    
    init(model: String, year: Int, bigTrunkValue: Double){
        super.init(model: model, year: year)
        self.bigTrunkValue = bigTrunkValue
        self.windowsState = { () -> [Window : WindowsAction] in
            var windowsState = [Window : WindowsAction]()
            windowsState[.frontLeft] = WindowsAction.close
            windowsState[.frontRight] = WindowsAction.close
            return windowsState
        }()
    }
    
    override func showWindowsState(){
        print("   Состояние окон:")
        for window in self.windowsState {
            switch window {
            case (.frontLeft, .close):
                print("     - водительское окно закрыто")
            case (.frontRight, .close):
                print("     - окно переднего пассажира закрыто")
            case (.frontLeft, .open):
                print("     - водительское окно открыто")
            case (.frontRight, .open):
                print("     - окно переднего пассажира открыто")
            default:
                print("     - Нет такого окна")
            }
        }
    }
    
    func openTrunk(){
        self.trunkStatus = .open
        print(self.trunkStatus.rawValue)
    }
    
    func closeTrunk(){
        self.trunkStatus = .close
        print(self.trunkStatus.rawValue)
    }
    
    func addCargo(newCargo: Double){
        self.openTrunk()
        guard let bigTrunkValue = self.bigTrunkValue else {return}
        if self.cargoValue + newCargo > bigTrunkValue {
            print("Слишком много груза, убавьте \(String(format: "%.2f", self.cargoValue + newCargo - bigTrunkValue)) литра(ов)")
            self.closeTrunk()
            return
        }
        self.cargoValue += newCargo
        print("Добавили груза: \(String(format: "%.2f", newCargo)) литра(ов)")
        self.closeTrunk()
    }
    
    func removeCargo(removedCargo: Double){
        self.openTrunk()
        if self.cargoValue - removedCargo < 0 {
            print("В кузове нет столько груза, там всего \(String(format: "%.2f", self.cargoValue)) литра(ов)")
            self.closeTrunk()
            return
        }
        self.cargoValue -= removedCargo
        print("Убавили груза: \(String(format: "%.2f", removedCargo)) литра(ов)")
        self.closeTrunk()
    }
    
    func openWindow(window: Window){
        if window == .rearLeft || window == .rearRight {
            print("Этих окон в грузовике нет\n")
            return
        }
        self.windowsState[window] = .open
    }
    
    func closeWindow(window: Window){
        if window == .rearLeft || window == .rearRight {
            print("Этих окон в грузовике нет \n")
            return
        }
        self.windowsState[window] = .close
    }
    
    func stopEngine(){
        self.engineState = .stop
    }
    
    func startEngine(){
        self.engineState = .start
    }
    
    func whatAboutThisCar(){
        print("\(icon) Ваш грузовик \(self.model) \(self.year) года выпуска.")
        print("Объем кузова - \(String(format: "%.2f", self.bigTrunkValue!) ) литров")
        print("Груза в кузове - \(String(format: "%.2f", self.cargoValue)) литров")
        self.showWindowsState()
        self.showEngineState()
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
