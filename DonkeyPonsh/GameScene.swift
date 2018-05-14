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
    // Scene main components and factories
    var player: Player?
    private var gui = GUI()
    private var environmentFactory: EnvironmentFactory?
    private var hazardFactory: HazardFactory?
    
    // Background music node and songs array
    private var backgroundMusic: SKAudioNode?
    private var songs = ["retroliver.mp3", "quasi.mp3", "purefrancesc.mp3", "quejio.mp3"]
    
    private var scoreTimer = Timer()
    private var sceneEnvironmentTimer = Timer()
    private var hazardTimer = Timer()
    
    private var hazards = [Hazard]()
    private var environmentObjects = [EnvironmentObject]()
    private var dumpableNodes = [SKNode]()
    private let MAX_DUMPABLE_NODES = 50
    
    private var hasGameEnded = false
    
    override func didMove(to view: SKView)
    {
        self.physicsWorld.contactDelegate = self
        
        startGame()
    }
    
    @objc func startGame()
    {
        // In case we're coming from an ended game
        hasGameEnded = false
        self.removeAllChildren()
        dumpableNodes.removeAll()
        
        // Class initialization
        player = Player(pos: CGPoint(x: self.frame.midX, y: self.frame.midY))
        environmentFactory = EnvironmentFactory(scene: self)
        hazardFactory = HazardFactory(scene: self)
        
        // Music init
        let bgMusic = SKAudioNode(fileNamed: songs[SyntacticSugar.random(0..<songs.count)])
        bgMusic.isPositional = false
        bgMusic.autoplayLooped = true
        backgroundMusic = bgMusic
        
        // Each second the player will get a point
        scoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updatePlayerScore), userInfo: nil, repeats: true)
        
        // Every three seconds a new platform will be added to the scene
        sceneEnvironmentTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.updateScene), userInfo: nil, repeats: true)
        
        // Every three seconds a new hazard will be generated. This time could be modified depending on the player's score
        hazardTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.updateHazards), userInfo: nil, repeats: true)
        
        // Camera initialization
        let camera = SKCameraNode()
        self.camera = camera
        camera.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        camera.addChild(gui) // We add the GUI as a child of the camera so its position becomes fixed in the scene
        
        // Scene initialization
        let floorSprite = SKTexture(image: #imageLiteral(resourceName: "floor1"))
        let floor = EnvironmentObject(pos: CGPoint(x: self.frame.midX, y: self.frame.minY + floorSprite.size().height / 2), rotationRadiant: CGFloat(0), startingSprite : floorSprite)
        
        // Start enviroment objects
        for _ in 0...4
        {
            let generatedEnviromentObject = environmentFactory!.generateEnvironment()
            self.addChild(generatedEnviromentObject)
            dumpableNodes.append(generatedEnviromentObject)
        }
        
        // Adding initial components to scene
        self.addChild(player!)
        self.addChild(camera)
        self.addChild(floor)
        self.addChild(bgMusic)

        gui.show()
        let highScore = UserDefaults.standard.value(forKey: "score") as? Int
        gui.setupHighScoreLabel(highScore: highScore == nil ? 0 : highScore!)
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        player!.blendAnimations()
        camera!.position.y += hasGameEnded ? 0 : 1.5

        if (player!.isBelowCamera())
        {
            gameOver()
        }
    }
    
    @objc func updatePlayerScore()
    {
        player!.score += 1
        gui.updateScore(score: player!.score)
    }
    
    @objc func updateScene()
    {
        let generatedEnviromentObject = environmentFactory!.generateEnvironment()
        self.addChild(generatedEnviromentObject)
        dumpableNodes.append(generatedEnviromentObject)
        
        // Remove enviromentObject
        if(dumpableNodes.count > MAX_DUMPABLE_NODES)
        {
            dumpableNodes.first?.removeFromParent()
            dumpableNodes.remove(at: 0)
        }
    }
    
    @objc func updateHazards()
    {
        let generatedHazard = hazardFactory!.generateHazard()
        self.addChild(generatedHazard)
        dumpableNodes.append(generatedHazard)
    }
    
    func gameOver()
    {
        if(!hasGameEnded)
        {
            let highScore = UserDefaults.standard.value(forKey: "score") as? Int
            if ( highScore == nil || player!.score > highScore! )
            {
                UserDefaults.standard.setValue(player!.score, forKey: "score")
            }
            
            backgroundMusic!.run(SKAction.changeVolume(to: 0.0, duration: 0))
            hasGameEnded = true
            scoreTimer.invalidate()
            sceneEnvironmentTimer.invalidate()
            hazardTimer.invalidate()
            
            player!.die()
            let _ = Timer.scheduledTimer(
                timeInterval: 3,
                target: self,
                selector: #selector(self.startGame),
                userInfo: nil,
                repeats: false)
        }
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
            print("CONTACT PLAYER - FLOOR")
            player!.isInAir = false
            player!.physicsBody?.affectedByGravity = false
            player!.hasStartedWalking = !player!.isIdle
        }
        
        // Begin contact player with hazard
        if(contact.bodyA.categoryBitMask == CategoryChannel.player.rawValue && contact.bodyB.categoryBitMask == CategoryChannel.hazard.rawValue
            || contact.bodyB.categoryBitMask == CategoryChannel.player.rawValue && contact.bodyA.categoryBitMask == CategoryChannel.hazard.rawValue)
        {
            print("CONTACT PLAYER - HAZARD")
            gameOver()
        }
    }
    
    func touchDown(atPoint pos : CGPoint)
    {
        player?.processGuiAction(action: gui.processInput(point: pos))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.touchDown(atPoint: touches.first!.location(in: camera!))
    }
}
