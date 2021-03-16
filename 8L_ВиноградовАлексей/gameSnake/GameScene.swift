//
//  GameScene.swift
//  gameSnake
//
//  Created by MICHAIL SHAKHVOROSTOV on 15.03.2021.
//

import SpriteKit
import GameplayKit

struct CollisionCategory {
    
    static let Snake: UInt32 = 0x1 << 0 //0001
    static let SnakeHead: UInt32 = 0x1 << 1 //0010
    static let Apple: UInt32 = 0x1 << 2 // 0100
    static let EdgeBody: UInt32 = 0x1 << 3 //1000
    
    
}

class GameScene: SKScene {
    
    var snake: Snake?

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.darkGray
       
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
        
        self.mainCreates(at: view)
        
    }
    
    func mainCreates(at view: SKView){
        let counterClockwiseButton = SKShapeNode()
        
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX+30, y: view.scene!.frame.minY+30)
        
        counterClockwiseButton.fillColor = UIColor.black
        counterClockwiseButton.strokeColor = UIColor.green
        counterClockwiseButton.lineWidth = 10
        
        counterClockwiseButton.name = "counterClockwiseButton"
        
        self.addChild(counterClockwiseButton)
        
        let clockwiseButton = SKShapeNode()
        
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX - 70, y: view.scene!.frame.minY + 30)
        clockwiseButton.fillColor = .black
        clockwiseButton.strokeColor = .green
        clockwiseButton.lineWidth = 10
        
        clockwiseButton.name = "clockwiseButton"
        
        self.addChild(clockwiseButton)
        
        createApple()
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
    
        self.addChild(snake!)
        
        self.physicsWorld.contactDelegate = self
        
        
        self.physicsBody?.categoryBitMask = CollisionCategory.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategory.Snake | CollisionCategory.SnakeHead
    }
    
    
    func createApple() {
        
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX-10)))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY-10)))
        
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "counterClockwiseButton" || touchesNode.name == "clockwiseButton" else {
                return
            }
            
            touchesNode.fillColor = .lightGray
            
            
            if touchesNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            } else if touchesNode.name == "clockwiseButton" {
                snake!.moveClockwise()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "counterClockwiseButton" || touchesNode.name == "clockwiseButton" else {
                return
            }
            
            touchesNode.fillColor = .black
            
        }
      
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
   
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        snake!.move()
    }
    
    func gameOver(){
        self.removeAllChildren()
        let gameOverView: UIView = {() -> UIView in
            let view = UIView()
            view.frame = self.view!.bounds
            view.backgroundColor = UIColor.red
            return view
        }()
        
        
        let gameOverLabel: UILabel = {() -> UILabel in
            let label = UILabel()
            label.frame = CGRect(x: gameOverView.center.x-100, y: gameOverView.center.y-100, width: 200, height: 50)
            label.backgroundColor = gameOverView.backgroundColor
            label.textColor = .blue
            label.textAlignment = .center
            label.text = "Game Over"
            return label
        }()
        
        let newGameButton: UIButton = {() -> UIButton in
            let button = UIButton()
            button.frame = CGRect(x: gameOverLabel.frame.minX, y: gameOverLabel.frame.minY+100, width: 200, height: 50)
            button.backgroundColor = .green
            button.setTitle("New Game", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.textAlignment = .center
            button.layer.cornerRadius = 15
            return button
        }()
        gameOverView.addSubview(newGameButton)
        gameOverView.addSubview(gameOverLabel)
        newGameButton.addTarget(self, action: #selector(newGame), for: .touchDown)
        self.view?.addSubview(gameOverView)
    }
    
    @objc func newGame(){
        for oneSubview in self.view!.subviews {
            oneSubview.removeFromSuperview()
        }
        self.mainCreates(at: self.view!)
    }
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let collisionObject = bodyes - CollisionCategory.SnakeHead
        
        switch collisionObject {
        case CollisionCategory.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA
                .node : contact.bodyB.node
            
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
            
        case CollisionCategory.EdgeBody:
            
            self.gameOver()
            
            break
            
        default:
            break
        
            
        }
    }
    
    
}
