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
    public enum State
    {
        case walkingLeft
        case walkingRight
        case jumpingLeft
        case jumpingRight
        case idle
        case dead
    }
    
    private let idleSprite = SKTexture(image: #imageLiteral(resourceName: "idle"))
    
    private let moveSprites = [SKTexture(imageNamed: "1"), SKTexture(imageNamed: "2")]
    private let deathSprites = [SKTexture(imageNamed: "1"), SKTexture(imageNamed: "2")]
    
    private var moveAnimation = SKAction.animate(with: [SKTexture(imageNamed: "1"), SKTexture(imageNamed: "2")], timePerFrame: 0.2)
    private var deathAnimation = SKAction.animate(with: [SKTexture(imageNamed: "1"), SKTexture(imageNamed: "2")], timePerFrame: 0.2)
    
    private var jumpSound = SKAudioNode(fileNamed: "jump")
    private var deathSound =  SKAudioNode(fileNamed : "death")
    
    private var state = State.idle
    
    init(pos: CGPoint)
    {
        let startingSprite = moveSprites[0]
        super.init(texture: startingSprite, color: UIColor.clear, size: startingSprite.size())
        position = pos;
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: startingSprite.size().width, height: startingSprite.size().height))
        self.zPosition = 0
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func processTouch(touch: UITouch, event: UIEvent?)
    {
    }
    
    public func respawnAt(position: CGPoint)
    {
        self.position = position
        state = State.idle
    }
    
    public func updateState()
    {
        if(state == State.dead)
        {
            return  // We let the programmer decide when the dead state has finished by calling respawnAt
        }
        if (physicsBody?.velocity.dx == 0 && physicsBody?.velocity.dy == 0)
        {
            state = State.idle
        }
        else if ((physicsBody?.velocity.dx)! < CGFloat(0))
        {
            state = State.walkingLeft
        }
        else if((physicsBody?.velocity.dx)! > CGFloat(0))
        {
            state = State.walkingRight
        }
        
        // TODO check jumps
    }
}
