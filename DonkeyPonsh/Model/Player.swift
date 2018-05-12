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
    private var jumpSprite: SKTexture?
    private var deathSprite: SKTexture?
    
    private var moveAnimation: SKAction?
    private var deathAnimation: SKAction?
    
    private var jumpSound = SKAudioNode(fileNamed: "jump")
    private var deathSound =  SKAudioNode(fileNamed : "death")
    
    private var isInAir = false
    private var isDead = false
    
    init(pos: CGPoint)
    {
        let startingSprite = idleSprite
        super.init(texture: startingSprite, color: UIColor.clear, size: startingSprite.size())
        self.scale(to: CGSize(width: 100, height: 100))
        position = pos;
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.friction = 0
        self.zPosition = 0
        moveSprites = [SKTexture(image: #imageLiteral(resourceName: "walk1")), SKTexture(image: #imageLiteral(resourceName: "walk2")), SKTexture(image: #imageLiteral(resourceName: "walk3"))]
        jumpSprite = SKTexture(image: #imageLiteral(resourceName: "jump"))
        deathSprite = SKTexture(image: #imageLiteral(resourceName: "death"))
        moveAnimation = SKAction.animate(with: moveSprites!, timePerFrame: 1.0)
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
        else if(isInAir)
        {
            print("Player#blendAnimations: AIR")
            self.texture = jumpSprite
        }
        else if ((physicsBody?.velocity.dx)! < CGFloat(0))
        {
            print("Player#blendAnimations: MOVE LEFT")
            self.run(moveAnimation!)
            xScale = xScale < 0 ? xScale * -1 : xScale
        }
        else if((physicsBody?.velocity.dx)! > CGFloat(0))
        {
            print("Player#blendAnimations: MOVE RIGHT")
            self.run(moveAnimation!)
            xScale = xScale > 0 ? xScale * -1 : xScale
        }
    }
    
    public func processGuiAction(action: GUI.GUIAction)
    {
        if(!isInAir)
        {
            switch action
            {
            case GUI.GUIAction.left:
                print("Player#processGuiAction: Action left")
                physicsBody?.velocity.dx = -horizontalSpeed
                break
                
            case GUI.GUIAction.up:
                print("Player#processGuiAction: Action up")
                physicsBody?.applyForce(CGVector(dx: 0, dy: jumpForce))
                break
                
            case GUI.GUIAction.right:
                print("Player#processGuiAction: Action right")
                physicsBody?.velocity.dx = horizontalSpeed
            default:
                print("Player#processGuiAction: default")
                break
            }
        }
    }
}
