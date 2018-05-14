//
//  EnvironmentFactory.swift
//  DonkeyPonsh
//
//  Created by Jandol on 12/5/18.
//  Copyright © 2018 apporelbotna. All rights reserved.
//

import UIKit
import SpriteKit

class EnvironmentFactory: NSObject
{
    private let environmentTextures = [SKTexture(image: #imageLiteral(resourceName: "floor1")), SKTexture(image: #imageLiteral(resourceName: "floor2")), SKTexture(image: #imageLiteral(resourceName: "floor3"))]
    
    private static let PLATFORMS_ANGLE = CGFloat.pi / 8
    private static let MAX_HEIGHT = 400
    private static let MIN_HEIGHT = 325
    
    private var lastHeight: CGFloat?
    private var isNextLeft = true
    
    private var scene: SKScene?
    
    init(scene: SKScene)
    {
        self.scene = scene
        lastHeight = scene.frame.minY
    }
    
    public func generateEnvironment() -> EnvironmentObject
    {
        var nextPosition = CGPoint()
        let nextHeight = lastHeight! + CGFloat(SyntacticSugar.random(EnvironmentFactory.MIN_HEIGHT..<EnvironmentFactory.MAX_HEIGHT))
        var nextRotation = CGFloat(0)
        
        if(isNextLeft)
        {
            nextRotation = -EnvironmentFactory.PLATFORMS_ANGLE
            nextPosition = CGPoint(x: scene!.frame.minX, y: nextHeight)
            isNextLeft = false
        }
        else
        {
            nextRotation = EnvironmentFactory.PLATFORMS_ANGLE
            nextPosition = CGPoint(x: scene!.frame.maxX, y: nextHeight)
            isNextLeft = true
        }
        lastHeight = nextHeight
        
        print("NEXT HEIGHT: " + String(describing: nextHeight))
        
        return EnvironmentObject(pos: nextPosition, rotationRadiant: nextRotation, startingSprite: environmentTextures[SyntacticSugar.random(0..<environmentTextures.count)])
    }
}
