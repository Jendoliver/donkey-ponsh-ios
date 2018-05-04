//
//  Player.swift
//  DonkeyPonsh
//
//  Created by Jandol on 4/5/18.
//  Copyright © 2018 apporelbotna. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKSpriteNode
{
    private let moveSprites = [SKTexture(imageNamed: "1"), SKTexture(imageNamed: "2")]
    private let deathSprites = [SKTexture(imageNamed: "1"), SKTexture(imageNamed: "2")]
    
    private var moveAnimation: SKAction
    private var deathAnimation: SKAction
    
    private var jumpSound: SKAudioNode
    private var deathSound: SKAudioNode
    
    init(pos: CGPoint)
    {
        let startingSprite = moveSprites[0]
        super.init(texture: startingSprite, color: UIColor.clear, size: startingSprite.size())
        position = position;
        moveAnimation = SKAction.animate(with: moveSprites, timePerFrame: 0.2)
        self.deathAnimation = SKAction.animate(with: deathSprites, timePerFrame: 0.2)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: startingSprite.size().width, height: startingSprite.size().height))
        self.zPosition = 0
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func processTouch(touch: UITouch, event: UIEvent?)
    {
        touch.
    }
}
