//
//  GameScene.swift
//  DonkeyPonsh
//
//  Created by Jandol on 4/5/18.
//  Copyright © 2018 apporelbotna. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    private var label: SKLabelNode?
    private var spinnyNode: SKShapeNode?
    
    private var player: Player?
    private var gui = GUI()
    
    override func didMove(to view: SKView) {
        
        //TODO Remove it's only for testing
        //self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        player = Player(pos: CGPoint(x: self.frame.midX, y: self.frame.midY))
        
        let enviroment = EnvironmentObject(pos: CGPoint(x: self.frame.midX, y: self.frame.minY), rotationRadiant: CGFloat(0), startingSprite : SKTexture(image: #imageLiteral(resourceName: "floor1")))
        
        self.addChild(player!)
        self.addChild(enviroment)
        self.addChild(gui)
        gui.show()
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        player!.blendAnimations()
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
