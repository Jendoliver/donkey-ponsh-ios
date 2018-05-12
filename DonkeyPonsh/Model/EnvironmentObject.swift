//
//  environmentObject.swift
//  DonkeyPonsh
//
//  Created by Albert Montagut on 8/5/18.
//  Copyright © 2018 apporelbotna. All rights reserved.
//

import UIKit
import SpriteKit

class EnvironmentObject: SKSpriteNode {
    
    var startingSprite : SKTexture?
    init(pos: CGPoint, rotationRadiant : CGFloat, startingSprite : SKTexture)
    {
        super.init(texture: startingSprite, color: UIColor.clear, size: startingSprite.size())
        
        self.startingSprite = startingSprite
        
        position = pos;
        self.zRotation = rotationRadiant
        self.zPosition = 0
        self.scale(to: CGSize(width: 3 * size.width, height: 3 * size.height))
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.categoryBitMask = CategoryChannel.floor.rawValue
        self.physicsBody?.collisionBitMask = CollisionChannel.environment.rawValue
        self.physicsBody?.contactTestBitMask = CollisionChannel.environment.rawValue
        physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
