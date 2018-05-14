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
    // Player movement constants
    private var jumpImpulse = CGFloat(500)
    private var horizontalSpeed = CGFloat(300)
    
    private let deathLaunchImpulse = CGFloat(30000)
    
    // Player sprites
    private let idleSprite = SKTexture(image: #imageLiteral(resourceName: "idle"))
    private var moveSprites: [SKTexture]?
    private var jumpSprites: [SKTexture]?
    private var deathSprites: [SKTexture]?
    
    // Player animations
    private var moveAnimation: SKAction?
    private var jumpAnimation: SKAction?
    private var deathAnimation: SKAction?
    
    // Player sounds
    private var jumpSound = SKAction.playSoundFileNamed("jump.mp3", waitForCompletion: false)
    private var deathSound =  SKAction.playSoundFileNamed("die.wav", waitForCompletion: false)
    
    // Pretty self explanatory
    var score = 0
    
    // Player states
    var isInAir = true
    var hasStartedWalking = false
    var isIdle = true
    var isDead = false
    
    init(pos: CGPoint)
    {
        let startingSprite = idleSprite
        super.init(texture: startingSprite, color: UIColor.clear, size: startingSprite.size())
        
        // Player physics init
        self.scale(to: CGSize(width: 100, height: 100))
        position = pos;
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.categoryBitMask = CategoryChannel.player.rawValue
        self.physicsBody?.collisionBitMask = CollisionChannel.environment.rawValue
        self.physicsBody?.contactTestBitMask = CollisionChannel.environment.rawValue
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.angularVelocity = 0
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.friction = 1.0
        self.zPosition = 0
        
        // Player sprites/animations init
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
    
    public func die()
    {
        print("Player#die")
        if (!isDead)
        {
            print("Player#die --> Trigger")
            isDead = true
            self.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
            self.run(deathSound)
            self.run(deathAnimation!)
            self.physicsBody!.affectedByGravity = false
            let _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.applyDieLaunch), userInfo: nil, repeats: false)
        }
    }
    
    @objc func applyDieLaunch()
    {
        self.physicsBody!.affectedByGravity = true
        self.physicsBody!.collisionBitMask = CollisionChannel.ghost.rawValue
        self.physicsBody!.contactTestBitMask = CollisionChannel.ghost.rawValue
        physicsBody?.applyForce(CGVector(dx: 0, dy: deathLaunchImpulse))
    }
    
    public func blendAnimations()
    {
        if(isDead || isIdle)
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
        if(isDead)
        {
            return
        }
        
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
                self.run(jumpSound)
                physicsBody?.applyImpulse(CGVector(dx: 0, dy: jumpImpulse))
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
