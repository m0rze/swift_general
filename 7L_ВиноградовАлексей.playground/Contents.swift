import UIKit

enum badHardware: Error {
    case lowCPUGHz, lowMemory, badGPU
}

enum GPUs: String{
    case Nvidia = "Nvidia"
    case AMD = "AMD"
    case both = "любая"
}

struct Games {
    
    enum GamesNames: String {
        case Fallout4 = "Fallout 4"
        case Minecraft = "Minecraft"
        case Cyberpunk2077 = "Cyberpunk 2077"
    }
    
    var game: GamesNames
    var cpu: Double
    var gpu: GPUs
    var memmoryValue: Int
    
    init(game: GamesNames){
        self.game = game
        
        switch game {
        case .Minecraft:
            self.cpu = 1.3
            self.gpu = .both
            self.memmoryValue = 8
        case .Fallout4:
            self.cpu = 2.5
            self.gpu = .AMD
            self.memmoryValue = 16
        case .Cyberpunk2077:
            self.cpu = 3.2
            self.gpu = .Nvidia
            self.memmoryValue = 32
        }
    }
    
}

struct MyPC{
    var cpu: Double
    var gpu: GPUs
    var memmoryValue: Int
    
    init(cpu: Double, gpu: GPUs, memoryValue: Int){
        self.cpu = cpu
        self.gpu = gpu
        self.memmoryValue = memoryValue
    }
}

class SystemRequirments{
    
    var myPC: MyPC
    var game: Games
    var goodPC: Bool = false
    
    
    init(myPC: MyPC, game: Games) {
        self.myPC = myPC
        self.game = game
    }
    
    func check() throws {
        guard self.myPC.cpu >= self.game.cpu else {
            throw badHardware.lowCPUGHz
        }
        
        guard (self.myPC.gpu == self.game.gpu) || (self.game.gpu == .both) else {
            throw badHardware.badGPU
        }
        
        guard self.myPC.memmoryValue >= self.game.memmoryValue else {
            throw badHardware.lowMemory
        }
        
        self.goodPC = true
    }
    
}

extension SystemRequirments: CustomStringConvertible{
    var description: String {
        if self.goodPC {
            return "Ваш компьютер \(self.myPC.cpu) ГГц, \(self.myPC.memmoryValue) Гб ОЗУ и видеокартой \(self.myPC.gpu.rawValue) соответствует требованиям для игры в \(self.game.game.rawValue)"
        } else {
            return "Ваш комп хлам, пора его выкидывать"
        }
    }
}


let mySuperPuperPC = SystemRequirments(myPC: MyPC(cpu: 4.3, gpu: .Nvidia, memoryValue: 16), game: Games(game: .Cyberpunk2077))


do{
    try mySuperPuperPC.check()
} catch badHardware.lowCPUGHz {
    print("Пора менять процессор")
} catch badHardware.badGPU {
    print("GPU не подходит")
} catch badHardware.lowMemory {
    print("Подбавьте вашему компу оперативы")
}

print(mySuperPuperPC)


let mySecondSuperPuperPC = SystemRequirments(myPC: MyPC(cpu: 2.3, gpu: .AMD, memoryValue: 16), game: Games(game: .Minecraft))

do{
    try mySecondSuperPuperPC.check()
} catch badHardware.lowCPUGHz {
    print("Пора менять процессор")
} catch badHardware.badGPU {
    print("GPU не подходит")
} catch badHardware.lowMemory {
    print("Подбавьте вашему компу оперативы")
}

print(mySecondSuperPuperPC)
