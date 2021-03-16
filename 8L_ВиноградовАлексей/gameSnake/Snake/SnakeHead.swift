//
//  SnakeHead.swift
//  gameSnake
//
//  Created by MICHAIL SHAKHVOROSTOV on 15.03.2021.
//

import UIKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint, diametr: CGFloat) {
        
        super.init(atPoint: point, diametr: diametr)

        self.physicsBody?.categoryBitMask = CollisionCategory.SnakeHead
        
        self.physicsBody?.contactTestBitMask = CollisionCategory.EdgeBody | CollisionCategory.Apple | CollisionCategory.Snake
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
