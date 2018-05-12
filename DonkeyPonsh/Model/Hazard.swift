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
    var startingSprite = SKTexture(image: #imageLiteral(resourceName: "idle"))
    
    private var deathSound =  SKAudioNode(fileNamed : "death")
    
    init(pos: CGPoint)
    {
        super.init(texture: startingSprite, color: UIColor.clear, size: startingSprite.size())
        position = pos;
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: startingSprite.size().width, height: startingSprite.size().height))
        self.physicsBody?.categoryBitMask = CollisionChannel.hazard.rawValue
        self.physicsBody?.friction = 0
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
