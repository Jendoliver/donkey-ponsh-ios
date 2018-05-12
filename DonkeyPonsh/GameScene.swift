//
//  GameScene.swift
//  DonkeyPonsh
//
//  Created by Jandol on 4/5/18.
//  Copyright © 2018 apporelbotna. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    private var label: SKLabelNode?
    private var spinnyNode: SKShapeNode?
    
    private var player: Player?
    private var gui = GUI()
    private var environmentFactory: EnvironmentFactory?
    
    override func didMove(to view: SKView)
    {
        self.physicsWorld.contactDelegate = self
        
        // this its for testing
        //self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        player = Player(pos: CGPoint(x: self.frame.midX, y: self.frame.midY))
        environmentFactory = EnvironmentFactory(scene: self)
        
        let floorSprite = SKTexture(image: #imageLiteral(resourceName: "floor1"))
        let floor = EnvironmentObject(pos: CGPoint(x: self.frame.midX, y: self.frame.minY + floorSprite.size().height / 2), rotationRadiant: CGFloat(0), startingSprite : floorSprite)
        
        let enviroment1 = environmentFactory!.generateEnvironment()
        let enviroment2 = environmentFactory!.generateEnvironment()
        let enviroment3 = environmentFactory!.generateEnvironment()
        
        self.addChild(enviroment1)
        self.addChild(enviroment2)
        self.addChild(enviroment3)
        
        self.addChild(player!)
        self.addChild(floor)
        self.addChild(gui)
        gui.show()
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        player!.blendAnimations()
    }
    
    func didEnd(_ contact: SKPhysicsContact)
    {
        // End contact player with floor
        if(contact.bodyA.categoryBitMask == CategoryChannel.player.rawValue && contact.bodyB.categoryBitMask == CategoryChannel.floor.rawValue
            || contact.bodyB.categoryBitMask == CategoryChannel.player.rawValue && contact.bodyA.categoryBitMask == CategoryChannel.floor.rawValue)
        {
            player?.isInAir = true
            player!.physicsBody?.affectedByGravity = true
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        // Begin contact player with floor
        if(contact.bodyA.categoryBitMask == CategoryChannel.player.rawValue && contact.bodyB.categoryBitMask == CategoryChannel.floor.rawValue
            || contact.bodyB.categoryBitMask == CategoryChannel.player.rawValue && contact.bodyA.categoryBitMask == CategoryChannel.floor.rawValue)
        {
            player!.isInAir = false
            player!.physicsBody?.affectedByGravity = false
            player!.hasStartedWalking = !player!.isIdle
        }
        
        // Begin contact player with hazard
        if(contact.bodyA.categoryBitMask == CategoryChannel.player.rawValue && contact.bodyB.categoryBitMask == CategoryChannel.hazard.rawValue
            || contact.bodyB.categoryBitMask == CategoryChannel.player.rawValue && contact.bodyA.categoryBitMask == CategoryChannel.hazard.rawValue)
        {
            player?.isDead = true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        player?.processGuiAction(action: gui.processInput(point: pos))
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.touchDown(atPoint: touches.first!.location(in: self))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}
