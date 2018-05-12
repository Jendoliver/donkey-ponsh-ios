//
//  Hazard.swift
//  DonkeyPonsh
//
//  Created by Jandol on 4/5/18.
//  Copyright © 2018 apporelbotna. All rights reserved.
//

import UIKit
import SpriteKit

class Hazard: SKSpriteNode
{
    var startingSprite = SKTexture(image: #imageLiteral(resourceName: "barrel"))
    
    private var deathSound =  SKAudioNode(fileNamed : "death")
    
    init(pos: CGPoint)
    {
        super.init(texture: startingSprite, color: UIColor.clear, size: startingSprite.size())
        
        self.scale(to: CGSize(width: 100, height: 100))
        position = pos;
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.height / 2)
        self.physicsBody?.categoryBitMask = CategoryChannel.hazard.rawValue
        self.physicsBody?.collisionBitMask = CollisionChannel.environment.rawValue
        self.physicsBody?.contactTestBitMask = CollisionChannel.environment.rawValue
        self.physicsBody?.friction = 0.3
        self.physicsBody?.restitution = CGFloat(SyntacticSugar.random(0..<1))
        self.zPosition = 0
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func processTouch(touch: UITouch, event: UIEvent?)
    {
    }
    
}
