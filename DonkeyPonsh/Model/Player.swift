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
    
    private var moveSprites: [SKTexture]?
    private var jumpSprite: SKTexture?
    private var deathSprite: SKTexture?
    
    private var moveAnimation: SKAction?
    private var deathAnimation: SKAction?
    
    private var jumpSound = SKAudioNode(fileNamed: "jump")
    private var deathSound =  SKAudioNode(fileNamed : "death")
    
    private var state = State.idle
    
    init(pos: CGPoint)
    {
        let startingSprite = idleSprite
        super.init(texture: startingSprite, color: UIColor.clear, size: startingSprite.size())
        self.scale(to: CGSize(width: 100, height: 100))
        position = pos;
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.zPosition = 0
        moveSprites = [SKTexture(image: #imageLiteral(resourceName: "walk1")), SKTexture(image: #imageLiteral(resourceName: "walk2")), SKTexture(image: #imageLiteral(resourceName: "walk3"))]
        jumpSprite = SKTexture(image: #imageLiteral(resourceName: "jump"))
        deathSprite = SKTexture(image: #imageLiteral(resourceName: "death"))
        moveAnimation = SKAction.animate(with: moveSprites!, timePerFrame: 0.2)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
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
