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
    private static let offset = CGFloat(250)
    private static let transparency = CGFloat(0.3)
    
    private let leftArrow = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "arrow")))
    private let rightArrow = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "arrow")))
    private let upArrow = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "arrow")))
    
    override init()
    {
        super.init()
        rightArrow.zRotation = CGFloat.pi
        upArrow.zRotation = -CGFloat.pi / 2
        self.zPosition = 1
        
        self.addChild(leftArrow)
        self.addChild(upArrow)
        self.addChild(rightArrow)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show()
    {
        var buttonSize = scene!.frame.width / 3
        let positionY = scene!.frame.minY + buttonSize / 2
        buttonSize += GUI.offset
        leftArrow.position = CGPoint(x: frame.maxX - buttonSize / 2, y: positionY)
        leftArrow.alpha = GUI.transparency
        upArrow.position = CGPoint(x: frame.midX, y: positionY)
        upArrow.alpha = GUI.transparency
        rightArrow.position = CGPoint(x: frame.minX + buttonSize / 2, y: positionY)
        rightArrow.alpha = GUI.transparency
    }
}
