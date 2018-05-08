//
//  environmentObject.swift
//  DonkeyPonsh
//
//  Created by Albert Montagut on 8/5/18.
//  Copyright © 2018 apporelbotna. All rights reserved.
//

import UIKit
import SpriteKit

class EnvironmentObject: SKSpriteNode {
    
    var startingSprite : SKTexture?
    init(pos: CGPoint, rotationRadiant : CGFloat, startingSprite : SKTexture)
    {
        super.init(texture: startingSprite, color: UIColor.clear, size: startingSprite.size())
        
        self.startingSprite = startingSprite
        
        position = pos;
        self.zRotation = rotationRadiant
        
        self.zPosition = 0
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: startingSprite.size().width, height: startingSprite.size().height))
        physicsBody?.isDynamic = false
        
        //self.scale(to: CGSize(width: 100, height: 100))
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
