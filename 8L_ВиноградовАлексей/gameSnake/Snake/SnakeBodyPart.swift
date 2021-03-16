//
//  SnakeBodyPart.swift
//  gameSnake
//
//  Created by MICHAIL SHAKHVOROSTOV on 15.03.2021.
//

import UIKit
import SpriteKit


class SnakeBodyPart: SKShapeNode {
 
    var diametr: CGFloat?
    
    init(atPoint point: CGPoint, diametr: CGFloat = 10) {
        super.init()
        self.diametr = diametr
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diametr, height: diametr)).cgPath
        
        fillColor = .green
        strokeColor = .green
        lineWidth = 5
        
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: diametr-4, center: CGPoint(x: 5, y: 5))
        self.physicsBody?.categoryBitMask = CollisionCategory.Snake
        
        self.physicsBody?.contactTestBitMask = CollisionCategory.EdgeBody | CollisionCategory.Apple
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
