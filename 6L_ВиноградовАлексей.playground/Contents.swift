import UIKit

class Queue<Q: Comparable & Equatable>{
    
    var queue: [Q]
    
    init(queue: [Q]) {
        self.queue = queue
    }
    
    func popLast(){
        self.queue.removeLast()
    }
    
    func popFirst(){
        self.queue.removeFirst()
    }
    
    func push(new element: Q){
        self.queue.append(element)
    }
    
    func reverseMyQueue(){
        self.queue.reverse()
    }
    
    func sortUpMyQueue(){
        self.queue.sort {
            $0 < $1
        }
    }
    
    func sortDownMyQueue(){
        self.queue.sort {
            $0 > $1
        }
    }
    
    func shuffleMyQueue(){
        self.queue.shuffle()
    }
    
    func showMyQueue(){
        print(queue)
    }
    
}

extension Queue{
    subscript(index: Int) -> Q? {
        if self.queue.indices.contains(index) {
            return self.queue[index]
        }
        return nil
    }
}

let myIntQueue = Queue(queue: [1,2,7,9,3,4,0])
myIntQueue.showMyQueue()
myIntQueue.push(new: 5)
print(myIntQueue[22] as Any)
if let element = myIntQueue[2] {
    print(element)
}
myIntQueue.shuffleMyQueue()
myIntQueue.showMyQueue()
myIntQueue.sortUpMyQueue()
myIntQueue.showMyQueue()
myIntQueue.sortDownMyQueue()
myIntQueue.showMyQueue()
myIntQueue.popFirst()
myIntQueue.showMyQueue()


let myStrQueue = Queue(queue: ["Mark", "David", "John", "Bob", "Jessica", "Jena", "Sindy"])
myStrQueue.showMyQueue()
myStrQueue.push(new: "Sheldon")
myStrQueue.reverseMyQueue()
myStrQueue.showMyQueue()
myStrQueue.shuffleMyQueue()
myStrQueue.showMyQueue()
myStrQueue.sortDownMyQueue()
myStrQueue.showMyQueue()
myStrQueue.popLast()
myStrQueue.showMyQueue()
if let element = myStrQueue[3]{
    print(element)
}
