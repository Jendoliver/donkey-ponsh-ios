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
    private var jumpForce = CGFloat(20000)
    private var horizontalSpeed = CGFloat(250)
    
    private let idleSprite = SKTexture(image: #imageLiteral(resourceName: "idle"))
    
    private var moveSprites: [SKTexture]?
    private var jumpSprites: [SKTexture]?
    private var deathSprites: [SKTexture]?
    
    private var moveAnimation: SKAction?
    private var jumpAnimation: SKAction?
    private var deathAnimation: SKAction?
    
    private var jumpSound = SKAudioNode(fileNamed: "jump")
    private var deathSound =  SKAudioNode(fileNamed : "death")
    
    var isInAir = true
    var hasStartedWalking = false
    var isIdle = true
    var isDead = false
    
    init(pos: CGPoint)
    {
        let startingSprite = idleSprite
        super.init(texture: startingSprite, color: UIColor.clear, size: startingSprite.size())
        
        self.scale(to: CGSize(width: 100, height: 100))
        position = pos;
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.categoryBitMask = CategoryChannel.player.rawValue
        self.physicsBody?.collisionBitMask = CollisionChannel.environment.rawValue
        self.physicsBody?.contactTestBitMask = CollisionChannel.environment.rawValue
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.friction = 0
        self.zPosition = 0
        
        moveSprites = [SKTexture(image: #imageLiteral(resourceName: "walk1")), SKTexture(image: #imageLiteral(resourceName: "walk2")), SKTexture(image: #imageLiteral(resourceName: "walk3"))]
        jumpSprites = [SKTexture(image: #imageLiteral(resourceName: "jump"))]
        deathSprites = [SKTexture(image: #imageLiteral(resourceName: "death"))]
        moveAnimation = SKAction.animate(with: moveSprites!, timePerFrame: 0.1)
        moveAnimation = SKAction.repeatForever(moveAnimation!)
        jumpAnimation = SKAction.animate(with: jumpSprites!, timePerFrame: 0.1)
        jumpAnimation = SKAction.repeatForever(jumpAnimation!)
        deathAnimation = SKAction.animate(with: deathSprites!, timePerFrame: 0.1)
        deathAnimation = SKAction.repeatForever(deathAnimation!)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func respawnAt(position: CGPoint)
    {
        self.position = position
    }
    
    public func blendAnimations()
    {
        if(isDead)
        {
            print("Player#blendAnimations: DEAD")
            return  // We let the programmer decide when the dead state has finished by calling respawnAt
        }
        
        if(isIdle)
        {
            return
        }
        
        // Texture orientation
        if((physicsBody?.velocity.dx)! < CGFloat(-100))
        {
            xScale = xScale < 0 ? xScale * -1 : xScale
        }
        else if((physicsBody?.velocity.dx)! > CGFloat(100))
        {
            xScale = xScale > 0 ? xScale * -1 : xScale
        }
        
        // Air or landed
        if(isInAir)
        {
            self.run(jumpAnimation!)
        }
        else if(hasStartedWalking)
        {
            self.run(moveAnimation!)
            hasStartedWalking = false
        }
    }
    
    public func processGuiAction(action: GUI.GUIAction)
    {
        switch action
        {
        case GUI.GUIAction.left:
            print("Player#processGuiAction: Action left")
            physicsBody?.velocity.dx = -horizontalSpeed
            hasStartedWalking = true
            break
            
        case GUI.GUIAction.up:
            if(!isInAir)
            {
                print("Player#processGuiAction: Action up")
                physicsBody?.applyForce(CGVector(dx: 0, dy: jumpForce))
                isInAir = true
            }
            break
            
        case GUI.GUIAction.right:
            print("Player#processGuiAction: Action right")
            physicsBody?.velocity.dx = horizontalSpeed
            hasStartedWalking = true
        default:
            print("Player#processGuiAction: default")
            break
        }
        isIdle = false
    }
}
