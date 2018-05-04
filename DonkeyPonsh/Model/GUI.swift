//
//  GUI.swift
//  DonkeyPonsh
//
//  Created by Jandol on 4/5/18.
//  Copyright © 2018 apporelbotna. All rights reserved.
//

import UIKit
import SpriteKit

class GUI: SKNode
{
    private let leftArrow = SKSpriteNode(texture: SKTexture(imageNamed: "arrow"))
    private let rightArrow = SKSpriteNode(texture: SKTexture(imageNamed: "arrow"))
    private let upArrow = SKSpriteNode(texture: SKTexture(imageNamed: "arrow"))
    
    override init()
    {
        super.init()
        rightArrow.zRotation = CGFloat.pi
        upArrow.zRotation = -CGFloat.pi / 2
        self.zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
